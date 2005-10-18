Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVJRXde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVJRXde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJRXde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:33:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751491AbVJRXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:33:33 -0400
Date: Tue, 18 Oct 2005 16:32:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: jesper.juhl@gmail.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       adilger@clusterfs.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Test for sb_getblk return value
Message-Id: <20051018163201.79730947.akpm@osdl.org>
In-Reply-To: <200510171356.11639.glommer@br.ibm.com>
References: <20051017132306.GA30328@br.ibm.com>
	<9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com>
	<200510171356.11639.glommer@br.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glauber de Oliveira Costa <glommer@br.ibm.com> wrote:
>
> I'm resending it now with the changes you suggested. 
> Actually, 2 copies of it follows. 

argh.  Please never attach multiple patches to a single email.

And please always include a complete, uptodate changelog with each iteration
of a patch.  I don't want to have to troll back through the mailing list,
identify the initial changelog and then replay the email thread making any
needed updates to that changelog.

Also please review section 11 of Documentation/SubmittingPatches then
include a Signed-off-by: with your patches.

> In the first one(v2), I kept the style in the changes in resize.c, as this 
> seems to be the default way things like this are done there. In the other, 
> (v3), I did statement checks in the way you suggested in both files.

Don't worry about the surrounding style - if it's wrong, it's wrong.  Just
stick with Documentation/CodingStyle.

Do this:

		if (!bh) {

and not this:

		if (!bh){

> Also, sorry for the last mail. I got a problem with my relay, and my mail 
> address was sent wrong before I noticed that. Mails sent to it will probably 
> return.

The change to update_backups() is wrong - it will leave a JBD transaction
open on return.

Please fix all that up and resend. 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt may prove useful,
thanks.

