Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbRFZWXD>; Tue, 26 Jun 2001 18:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbRFZWWx>; Tue, 26 Jun 2001 18:22:53 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:33228 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265128AbRFZWWo>; Tue, 26 Jun 2001 18:22:44 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: John Stoffel <stoffel@casc.com>, Jason McMullan <jmcmullan@linuxcare.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
Date: Wed, 27 Jun 2001 00:21:09 +0200
Organization: Econos
Message-ID: <qn1ijt06guu1014p6om26opk7k5933kb7i@4ax.com>
In-Reply-To: <15160.65442.682067.38776@gargle.gargle.HOWL> <Pine.LNX.4.33L.0106261838320.23373-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0106261838320.23373-100000@duckman.distro.conectiva>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Tue, 26 Jun 2001 18:42:56 -0300 (BRST), Rik van Riel wrote:

>On Tue, 26 Jun 2001, John Stoffel wrote:
>
>> Or that we're doing big sequential reads of file(s) which are
>> larger than memory, in which case expanding the cache size buys
>> us nothing, and can actually hurt us alot.
>
>That's a big "OR".  I think we should have an algorithm to
>see which of these two is the case, otherwise we're just
>making the wrong decision half of the time.

Windows NT/2000 has flags that can be for each CreateFile operation
("open" in Unix terms), for instance

  FILE_ATTRIBUTE_TEMPORARY

  FILE_FLAG_WRITE_THROUGH
  FILE_FLAG_NO_BUFFERING
  FILE_FLAG_RANDOM_ACCESS
  FILE_FLAG_SEQUENTIAL_SCAN

If Linux does not have mechanism that would allow the signalling of
specific use case, it might be helpful to implement such a hinting system?

Disclaimer: I am clueless about what the kernel provides at this time.
