Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVCBWX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVCBWX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCBWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:19:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:39869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262500AbVCBWRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:17:18 -0500
Date: Wed, 2 Mar 2005 14:17:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: marcelo.tosatti@cyclades.com, myeatman@vale-housing.co.uk,
       linux-kernel@vger.kernel.org, gene.heskett@verizon.net
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-Id: <20050302141711.00ec7147.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503022334280.9132@kai.makisara.local>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
	<20050302120332.GA27882@logos.cnet>
	<Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
	<20050302132512.5853cd3b.akpm@osdl.org>
	<Pine.LNX.4.61.0503022334280.9132@kai.makisara.local>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
>
> f seek with tape is changed back to returning success, this would enable 
> correct tar --verify at the beginning of the tape. However, I am not sure 
> what happens if we are not at the beginning. I will investigate this and 
> suggest a long term fix to the tar people (a fix that should be compatible 
> with all Unix tape semantics I know) and also suggest possible fixes to st 
> (this may include automatic writing of a filemark when BSF is used after 
> writes).

Yes, please let's get a tar fix in the pipeline.

GNU tar must run on a lot of operating systems.  It's odd.

> If you think want to make st return success for seeks even if nothing 
> happens (as it did earlier), I don't have anything against that. It would 
> solve the practical problem several people have reported recently. (My 
> recommendation for the people seeing this problem is to do verification 
> separately with 'tar -d'.)

Yes, I think we need to grit our teeth and do this.  I'll stick a comment
in there.
