Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315221AbSENXGa>; Tue, 14 May 2002 19:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316137AbSENXG3>; Tue, 14 May 2002 19:06:29 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:64009 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315221AbSENXG3>;
	Tue, 14 May 2002 19:06:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: blenderman@wanadoo.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP problem when compiling 
In-Reply-To: Your message of "Tue, 14 May 2002 19:35:51 +0200."
             <200205141935.51167.blenderman@wanadoo.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 09:06:18 +1000
Message-ID: <14699.1021417578@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 19:35:51 +0200, 
Pol <blenderman@wanadoo.be> wrote:
>I get this error when I compile the kernel 2.4.18 with make -j (make bzImage)
>cpp0: gcc: Internal compiler error: program cc1 got fatal signal 11

Unless you have a very large machine, make -j when using make >= 3.78
will overload the system.  Use make -jN where N == number of cpus as a
starting point.  gcc has been known to segfault when it runs out of
memory.

