Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSDIPiJ>; Tue, 9 Apr 2002 11:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSDIPiI>; Tue, 9 Apr 2002 11:38:08 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:19312 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S293131AbSDIPiI>;
	Tue, 9 Apr 2002 11:38:08 -0400
Date: Tue, 9 Apr 2002 16:37:48 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.33.0204091633030.1098-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Priya,

The portable way to determine the number of cpus _online_ is:

if [ -x /usr/bin/getconf ] ; then
  numprocs=$(/usr/bin/getconf _NPROCESSORS_ONLN)
  if [ $numprocs -eq 0 ]; then
    numprocs=1
  fi
else
  numprocs=1
fi

at least that is the number I usually pass to "make -j$numprocs" when
compiling large software projects.

Regards,
Tigran

On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:

> Hi!
>   I have a script that is using the /cpu/procinfo file to determine the number of cpus present in the system. But I would like to implement it using a system call rather than use the environment variables?? I couldn't find a system call for linux that would give me the result. Could anyone please let me know if there is one for redhat linux??
>
> Thanks for your time,
> Priya
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

