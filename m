Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVGHKea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVGHKea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVGHKdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:33:19 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:47483 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262471AbVGHKaP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:30:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dsTxHZHejpUXUUSxoXUTc9qm2Js2tUqWF0O69VW2xVgsvFNI2iGSe8Cub4Tk6oZ0l/i1fVGZ5Zuee+aIZ3ToioxcoHuvainQfCYkOy6mXz2AXf/l4tcniFh2AMcOaVDWd0eiWWD5svQ1iBlSK6eaGWm7C16VSZ1qWYLZrKH65To=
Message-ID: <84144f0205070803307548683a@mail.gmail.com>
Date: Fri, 8 Jul 2005 13:30:12 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Subject: Re: Developing a filesystem
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4fec73ca05070803144da4b3c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4fec73ca05070803144da4b3c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Guillermo López Alejos <glalejos@gmail.com> wrote:
> Hi,
> 
> As I anounced a couple of weeks ago, I'm studying how to build a new
> filesystem. I have taken a look at the ramfs and also read some
> documentation about.
> 
> Now I'm writing my own dummyfs (based on ramfs) to know how this
> works, but I'm having problems compiling it; I need to include the
> "linux/fs.h" header file to have access to some structures definitions
> (such as struct file_system_type), but this is giving me some errors.
> So I think that I have to integrate my code with the kernel sources to
> make it compile.
> 
> Therefore, my question is, is there any way to check wheter my code
> compiles or not without having to integrate it with the kernel code?
> If not, is there any tutorial to learn how to integrate a filesystem
> into the Linux kernel code?

1. Example Makefile for an out-of-tree filesystem: 

http://cvs.sourceforge.net/viewcvs.py/v9fs/linux-9p/Makefile?rev=2.0&view=auto

2. Putting it into the kernel:

cat fs/ramfs/Makefile
grep -i ramfs fs/Kconfig

                              Pekka
