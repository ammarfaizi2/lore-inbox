Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWGCRaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWGCRaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWGCRaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:30:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53169 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751208AbWGCRaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:30:24 -0400
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       serue@us.ibm.com
In-Reply-To: <20060628051935.GA29920@ftp.linux.org.uk>
References: <20060627221436.77CCB048@localhost.localdomain>
	 <20060627221457.04ADBF71@localhost.localdomain>
	 <20060628051935.GA29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 10:30:14 -0700
Message-Id: <1151947814.11159.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 06:19 +0100, Al Viro wrote:
>         * make the moments when i_nlink hits 0 bump the superblock writers
> count; drop it when such sucker gets freed on final iput. 

Could you elaborate on this one a bit?  

I assume that there are rules that once i_nlink hits 0, it never goes
back up again.  It seems that a whole bunch (if not all) of the
individual filesystems do things to it.  Is it really necessary to go
into all of those looking for the places that i_nlink hits 0?  Seems
like it would be an awful lot of patching.

-- Dave


