Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVILVb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVILVb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVILVb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:31:27 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:902 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932265AbVILVb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uxm37yz9bFlQIErZnO7D+l6nMaWMwddItg5O9Q6EYJWBL+nBdyioy3cVyxxkiOUP7P6twgWgLCQCRxyBdfM9hLuAJIHoyvAar1JKjHMDOdQJ4hcpGwdjvxGrmTbMMGdPQHAIMHmiz+UXJxbO7Ggy20PJRY+zdH5KZ0qmUb03yUM=
Message-ID: <d120d5000509121431765f52c8@mail.gmail.com>
Date: Mon, 12 Sep 2005 16:31:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: git tag in localversion
Cc: linux-kernel@vger.kernel.org, klive@cpushare.com,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050912210836.GL13439@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912210836.GL13439@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Andrea Arcangeli <andrea@suse.de> wrote:
> Hello,
> 
> The patch that adds the git tag in the localversion is screwing klive a
> bit, see the 2.6.13-g* entries in
> http://klive.cpushare.com/?branch=unknown
> 
> Those are supposed to go in the homepage but they're not recognized
> anymore due the git tag and so they go in the unknown page.
> 
> So either we add a branch name in /proc/branch (for mainline that will
> be "2.6.13 mainline", that tells the release number and the branch, or I
> shall do a bit more of regexp on the localversion). The branch tag has
> the advantage of being able to more reliably recognize non-mainline
> kernels as well, klive was made for mainline, I didn't expect so many
> users with vendor kernels, but that's ok as long as the regexp on uname
> -r works ;). The regexp is already falling apart with distro like
> debian, so the sort of /proc/branch was suggested by them infact.
> 
> Yet another way would be to remove the git tag from the localversion ;),
> but I doubt that it would be ok with you since it'd pratically backout
> the feature. I don't think it would be enough for you to have the git
> tag in /proc, the way I understand it you want it in the uts_release to
> avoid overwriting system.map.
> 
> Suggestions welcome thanks.

I think this question better be addressed to Ian or Sam (Andrea, did
you pick a wrong entry from your address book?), adding them to CC...

-- 
Dmitry
