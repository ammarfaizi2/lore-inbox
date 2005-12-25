Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVLYKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVLYKKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVLYKKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 05:10:18 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:29488 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbVLYKKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 05:10:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rW6rXSvRptC3pxyYaGhYAd3XN9N8AXWMUgpfCRzWPhpMxhctG8nfXo1pT0rhxih9NSwNeO2Xk2q5mLP0b6kNq5NEHD+TmoWlkd5uto4yA2LW4Uy4vgA98LPEaRx6+g0QMjr8VOeUfwhJ47mZsivQERvvsseTE7mBYnQm1CZlRpM=
Message-ID: <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
Date: Sun, 25 Dec 2005 13:10:16 +0300
From: regatta <regatta@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: FS possible security exposure ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1135503601.2946.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
	 <1135503601.2946.6.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Vi in Solaris and Vim in Linux, do you think this is the
problem ? (because when I use "echo BLABAL >> FILE_I_DONT_OWN_IT"  it
will give me permission denied in Linux)

but if you think about it, how could the system allow the user to
modify a file that he don't own it and he don't have write privilege
on the file just because he has write in the parent directory ?

Maybe I'm wrong, but is this normal ? please let me know

BTW: is there any document, article or any page about this so I can
show it to my boss :)

Thanks




On 12/25/05, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > (when you have hundred of users and hundred of NFS and thousand of
> > net groups you don't want a user to edit other file just because he
> > has write permission in the patent dir).
>
> if you have write permission in the directory you're allowed to
> 1) create new files
> 2) rename existing files
> 3) delete files
> 4) rename files over existing files (combo of 2 and 3 sort of)
>
> so an "edit" as you describe is
> * create a new file with the new (eg modified) content
> * rename the new file over the existing file
>
> that's how reliable editors operate (the rename-over-file is an atomic
> operation) to avoid any possibility of dataloss due to crashes etc.
>
> Since the 1-4 rules are pretty much there for all unixes...
> Maybe your solaris editor doesn't do editing in this way?
>
>
>
>


--
Best Regards,
--------------------
-*- If Linux doesn't have the solution, you have the wrong problem -*-
