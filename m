Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDNAII>; Sat, 13 Apr 2002 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311475AbSDNAIH>; Sat, 13 Apr 2002 20:08:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:35344 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311454AbSDNAIH>;
	Sat, 13 Apr 2002 20:08:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated 
In-Reply-To: Your message of "Sat, 13 Apr 2002 11:52:49 MST."
             <20020413185249.GA31470@tapu.f00f.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 10:07:56 +1000
Message-ID: <32583.1018742876@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2002 11:52:49 -0700, 
Chris Wedgwood <cw@f00f.org> wrote:
>On Fri, Apr 12, 2002 at 02:31:50PM -0700, David S. Miller wrote:
>
>    If you need to depend upon a consistent snapshot of what some
>    other thread writes into a file, you must have some locking
>    protocol to use to synchronize with that other thread.
>
>Appends of small-writes (for whatever reason) seems to be atomic,
>AFAIK nobody gets corrupt apache logs for example.

Write in append mode must be atomic in the kernel.  Whether a user
space write in append mode is atomic or not depends on how many write()
syscalls it takes to pass the data into the kernel.  Each write()
append will be atomic but multiple writes can be interleaved.

