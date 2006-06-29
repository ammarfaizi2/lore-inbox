Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWF2F1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWF2F1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWF2F1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:27:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:50627 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932190AbWF2F1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:27:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XeZh1tYT6NPlGbK7K5gKaR7ejxfQ01LqgRGnZNLMm/PbO7R4kCrIJdnLGcTqitkJPF2XkPnLu7aTrZPsW2YOspGrj8XmunPPtg5pZMdoE/Vvjv+zrZq00yQ5iUpYVYHR9sZWdaseXzPdQB22fj273twKYOxj3eYKFW80gd7P3Es=
Message-ID: <84144f020606282227x662bdd48read6218cf2bab8fc@mail.gmail.com>
Date: Thu, 29 Jun 2006 08:27:01 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Russ Cox" <rsc@swtch.com>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Cc: "Eric Sesterhenn" <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151535167.28311.1.camel@alice>
	 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
X-Google-Sender-Auth: 04f07fea4ad5de12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Russ Cox <rsc@swtch.com> wrote:
> >  error:
> >         kfree(fcall);
> > -       if (ret)
> > -               iput(ret);
> > -
> >         return ERR_PTR(err);
> >  }
>
> What about when someone changes the code and does have ret != NULL here?
> This seems like reasonable defensive programming to me.

Well, you're not supposed to change code without auditing for things
like this anyway. Also, I fail to see why/how you would change
v9fs_inode_from_fid() for that to happen?  I'd say kill the check.

                                                   Pekka
