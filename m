Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGQN5d>; Wed, 17 Jul 2002 09:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGQN5d>; Wed, 17 Jul 2002 09:57:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34231 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314811AbSGQN5c>;
	Wed, 17 Jul 2002 09:57:32 -0400
Date: Wed, 17 Jul 2002 10:00:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: riel@conectiva.com.br, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207171346.g6HDkb1l028358@burner.fokus.gmd.de>
Message-ID: <Pine.GSO.4.21.0207170953370.27768-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jul 2002, Joerg Schilling wrote:
 
> Is there any problem with using a ioctl() from upper layer kernel to the low 
> level drivers (living under the SW raid) to reduce the number of retries to a 
> reasonable value in this case?
> 
> The main design goal for UNIX as to keep it simple. There is no need for a 
> complex cross layer error control.

... and ioctl(2) is a gross violation of that design goal.  Ask the authors
of UNIX how they feel about that kludge, let alone propagation of said kludge
beyond the TTY layer where it had originated (or about the entire v7 TTY layer,
for that matter - v8 and later had thrown that crap away).

If you care about design philosophy of UNIX - at the very least take a hard
look at APIs you are using.  Sheesh...

