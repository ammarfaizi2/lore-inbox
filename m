Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbWKEQhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWKEQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWKEQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:37:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:49886 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932745AbWKEQhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:37:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hUOKgkdn8pSzaU7YbEbimZdnoVdNWyRvqAA6LdCQa7SJMDBeNljbEPWeheyE3buUp+d2LWjrTWULZxl+eVqyTG1xjcBJzG7WIszHiQ0ixqpiF+dy6q5iCXd/Y6t/kkxwjN0sAKdG2s06tgl/H+1l4wTZS+YUaLxbJlV35/nYaMA=
Message-ID: <787b0d920611050837i4b488167pcadfb9d70e96a372@mail.gmail.com>
Date: Sun, 5 Nov 2006 11:37:12 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, kangur@polcom.net,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061104210111.GB21485@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
	 <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
	 <20061104210111.GB21485@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Sat, 2006-11-04 14:59:53 -0500, Albert Cahalan <acahalan@gmail.com> wrote:

> > BTW, a person with disk recovery experience told me that drives
> > will sometimes reorder the sectors. Sector 42 becomes sector 7732,
> > sector 880880 becomes sector 12345, etc. The very best filesystems
> > can handle with without data loss. (for example, ZFS) Merely great
> > filesystems will at least recognize that the data has been trashed.
>
> Uh? This should be transparent to the host computer, so logical sector
> numbers won't change.

"should be" does not imply "won't"   :-)

On a drive which is capable of remapping sectors, imagine what
happens if the remapping data itself is corrupted. (the user data
is perfectly fine and is not being relocated)

What I mean is that the logical sector numbers not only change,
but they are the only thing changing. The user data never moves
to a different physical location, and is never intended to move.
The user data is perfectly readable. It just appears in the wrong
place as viewed by the OS.
