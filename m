Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311035AbSCUNNR>; Thu, 21 Mar 2002 08:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311614AbSCUNNI>; Thu, 21 Mar 2002 08:13:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5640 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311035AbSCUNMz>; Thu, 21 Mar 2002 08:12:55 -0500
Subject: Re: [PATCH] fcntl returns wrong error code
To: cyeoh@samba.org (Christopher Yeoh)
Date: Thu, 21 Mar 2002 13:28:45 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <15513.30999.494913.910369@gargle.gargle.HOWL> from "Christopher Yeoh" at Mar 21, 2002 05:09:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o2cX-0005At-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When fcntl(fd, F_DUPFD, b) is called where 'b' is greater than the
> maximum allowable value EINVAL should be returned. From POSIX:
> 
> "[EINVAL] The cmd argument is invalid, or the cmd argument is F_DUPFD and
> arg is negative or greater than or equal to {OPEN_MAX}, or ..."

Where does it mention rlimit ? Also we sort of have a problem since
OPEN_MAX is not a constant on Linux x86. I guess that means a libc enforced
behaviour or something for that bit
