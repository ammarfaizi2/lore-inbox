Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWEUHcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWEUHcK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 03:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWEUHcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 03:32:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:47317 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWEUHcJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 03:32:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P0nnON7hBdRbwjFtZr/pG3oJyWhkBri4Z6aEVlFGPYZNP9kMjYCbQwAD6dbYrWzCUrS0kAFhyNEEOBiEbIMyuBGzSF+SUzYr2WEmVKGC/gfDev17B3o1NZFnfqCAJzOYkFXI8vXrJdnETpPF/ovF/LcMXlS9hIJm5lI6+Ftvczs=
Message-ID: <7c3341450605210032j9eb3da6y5f307a3198957214@mail.gmail.com>
Date: Sun, 21 May 2006 08:32:09 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "George Nychis" <gnychis@cmu.edu>
Subject: Re: cannot load *any* modules with 2.4 kernel
Cc: "Willy Tarreau" <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <446FAEE3.6060003@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org>
	 <446FAEE3.6060003@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/06, George Nychis <gnychis@cmu.edu> wrote:
> Okay, so heres what I did.  I downloaded modutils version 2.4.27 and
> extracted it to /usr/local/modutils
>
> Then in my 2.4.32 kernel's Makefile, I changed the DEPMOD variable to
> point to /usr/local/modutils/sbin/depmod
>

Well thats a half-arsed way to do it.  The kernel makefile could be
using the new /usr/local/sbin/depmod and the system the old
/sbin/depmod /sbin/insmod /sbin/modprobe etc.

Just install the new modutils to /usr/local/ and then add
/usr/local/sbin to your $PATH _before_  /sbin etc. so it is read
first.

Nick
