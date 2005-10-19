Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVJSMan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVJSMan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJSMam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:30:42 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:9866 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750845AbVJSMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:30:42 -0400
Date: Wed, 19 Oct 2005 10:33:50 -0200
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       adilger@clusterfs.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Test for sb_getblk return value
Message-ID: <20051019123350.GA25893@br.ibm.com>
References: <20051017132306.GA30328@br.ibm.com> <9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com> <200510171356.11639.glommer@br.ibm.com> <20051018163201.79730947.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018163201.79730947.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: glommer@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thanks a lot for your patience and review. And also for the document. It
was really helpfull. Patch follows in next mail.



On Tue, Oct 18, 2005 at 04:32:01PM -0700, Andrew Morton wrote:
> Glauber de Oliveira Costa <glommer@br.ibm.com> wrote:
> >
> > I'm resending it now with the changes you suggested. 
> > Actually, 2 copies of it follows. 
> 
> argh.  Please never attach multiple patches to a single email.
> 
> And please always include a complete, uptodate changelog with each iteration
> of a patch.  I don't want to have to troll back through the mailing list,
> identify the initial changelog and then replay the email thread making any
> needed updates to that changelog.
> 
> Also please review section 11 of Documentation/SubmittingPatches then
> include a Signed-off-by: with your patches.
> 
> > In the first one(v2), I kept the style in the changes in resize.c, as this 
> > seems to be the default way things like this are done there. In the other, 
> > (v3), I did statement checks in the way you suggested in both files.
> 
> Don't worry about the surrounding style - if it's wrong, it's wrong.  Just
> stick with Documentation/CodingStyle.
> 
> Do this:
> 
> 		if (!bh) {
> 
> and not this:
> 
> 		if (!bh){
> 
> > Also, sorry for the last mail. I got a problem with my relay, and my mail 
> > address was sent wrong before I noticed that. Mails sent to it will probably 
> > return.
> 
> The change to update_backups() is wrong - it will leave a JBD transaction
> open on return.
> 
> Please fix all that up and resend. 
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt may prove useful,
> thanks.
> 
> 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
