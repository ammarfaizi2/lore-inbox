Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315572AbSEQKry>; Fri, 17 May 2002 06:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315577AbSEQKrx>; Fri, 17 May 2002 06:47:53 -0400
Received: from violet.setuza.cz ([194.149.118.97]:15120 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315572AbSEQKrx>;
	Fri, 17 May 2002 06:47:53 -0400
Subject: Re: counters
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3CE4C895.EB34A245@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 May 2002 12:47:53 +0200
Message-Id: <1021632473.250.1.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-17 at 11:08, Manik Raina wrote:
> 
> 	Thanks for your response. What i meant was 
> 	every process could have an account of how
> 	many bytes were read/written to various
> 	filesystems/sockets using read()/write()
> 	system calls. 
> 
> 	We could dump this stuff in /proc and
> 	it could tell us which processes are
> 	heavily IO bound.
> 
> 	I am wondering if this information will
> 	be useful to anyone.

Hi Manik

and sorry that I read only half of your initial post.
I had a quick look at fs/read_write.c.

I don't see any hook in the functions here, to perform such a task. And
here this should belong to -- shouldn't it?

the functions could add ``count'' to the procfs entry of ``current''.
(just a thought) This info could be valuable - I think - if it wouldn't
make a large performance issue.

Regards
Frank


