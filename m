Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272140AbRHVWBI>; Wed, 22 Aug 2001 18:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272141AbRHVWA6>; Wed, 22 Aug 2001 18:00:58 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:28684 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S272140AbRHVWAr>; Wed, 22 Aug 2001 18:00:47 -0400
Date: Wed, 22 Aug 2001 18:00:30 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Nicholas Knight <tegeran@home.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
In-Reply-To: <01082214532302.00394@c779218-a>
Message-ID: <Pine.LNX.4.33.0108221757020.17244-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Nicholas Knight wrote:

> Here's an end-user perspective for you... I just spent 2 days trying to 
> figure out how to use my CD-RW drive to read when using ide-scsi, before 
> I finnaly realized that I had to do it by disabling ATAPI CD support and 
> enabling SCSI CD support..

Just doing hdX=scsi would have been enough, however. Except it doesn't 
work (currently) if ide-scsi is a module.

I agree with Alan that the problem is the grab-on-load strategy that
ide-scsi (and ide-cd for that matter) uses. I am willing to look into 
changing that to grab-on-open but I'm not sure if the change is an 
appropriate one for a stable series kernel -- it looks pretty non-trivial.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


