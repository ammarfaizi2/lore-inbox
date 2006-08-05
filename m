Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWHEHzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWHEHzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 03:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWHEHzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 03:55:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:36977 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422741AbWHEHzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 03:55:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s/RXp4mLRlhfYd6cUUJ7ZhA+DMiM3RZNMixhgdjJpFkImRlGDa3qJWcoJTr9gSohbnF3N+bttpL0BIQX5qDh2uh6+PSJgWuDkWk4PI/F2PrX3HcUSnYWV74ONJj3z8jVpb9mD+laVNRbr1YEh1QtQSSyo4XsmG8U3fBEss3/OXY=
Message-ID: <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>
Date: Sat, 5 Aug 2006 00:55:47 -0700
From: "Avinash Ramanath" <avinashr@gmail.com>
To: arjan@infradead.org
Subject: Re: Zeroing data blocks
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152435182.3255.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <abcd72470607081856i47f15dedre9be9278ffa9bab4@mail.gmail.com>
	 <1152435182.3255.39.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As per your suggestion, if I write a file with zero bits, it would
remap to other pages, and I might not zero the real pages. So is there
any other way that I can access the pages that a file is using?

On 7/9/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-07-08 at 18:56 -0700, Avinash Ramanath wrote:
> > I am trying to zero data blocks whenever an unlink is invoked as part
> > of a secure delete filesystem.
> [
> Hi,
>
> just a question... how secure do you want to be?
> (just asking because zeros might not be the best pattern when protecting
> against government type use :)
I would be using zeroes multiple times followed by random bit patterns.


> > I tried to zero the file by writing a buffer (of file size) with
> > zeroes onto the file.
>
> that's not so nice since there is no guarantee that the filesystem or
> the disk won't remap the data blocks underneath you...
>
>
>
