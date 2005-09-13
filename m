Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVIMBk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVIMBk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVIMBk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 21:40:56 -0400
Received: from ozlabs.org ([203.10.76.45]:42980 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932286AbVIMBkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 21:40:55 -0400
Date: Tue, 13 Sep 2005 11:38:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, James Bottomley <James.Bottomley@steeleye.com>,
       Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
Message-ID: <20050913013840.GG5382@krispykreme>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912161013.76ef833f.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> > With -mm2, I only get things like:
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468770
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468778
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468786
> > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > 	sda: Current: sense key: Aborted Command
> > 	    Additional sense: No additional sense information
> > 	Info fld=0x0
> > 	end_request: I/O error, dev sda, sector 10468794

What virtual scsi server are you using?

> Interesting.  It could be Andi's recent mempolicy.c changes
> (convert-mempolicies-to-nodemask_t.patch) or it could be some recent ppc64
> change or it could be something else ;)
> 
> Could the ppc64 guys please take a look?  In particular, it would be good
> to know if convert-mempolicies-to-nodemask_t.patch is innocent - I was
> planning on merging that upstream today.

Looking into it now.

Anton
