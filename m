Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313769AbSDHVwN>; Mon, 8 Apr 2002 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313770AbSDHVwM>; Mon, 8 Apr 2002 17:52:12 -0400
Received: from jalon.able.es ([212.97.163.2]:39381 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313769AbSDHVwL>;
	Mon, 8 Apr 2002 17:52:11 -0400
Date: Mon, 8 Apr 2002 23:51:58 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@tech9.net>
Cc: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-ID: <20020408215158.GA13043@werewolf.able.es>
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net> <1018301108.913.167.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.08 Robert Love wrote:
>On Mon, 2002-04-08 at 17:18, Kuppuswamy, Priyadarshini wrote:
>
>>   I have a script that is using the /cpu/procinfo file to determine the
>>  number of cpus present in the system. But I would like to implement it 
>> using a system call rather than use the environment variables?? I couldn't
>> find a system call for linux that would give me the result. Could anyone
>> please let me know if there is one for redhat linux??
>
>Linux does not implement such a syscall.  Note
>

How about this:

#include <sys/sysinfo.h>       
...
    //nproc = get_nprocs(); // Available processors
    nproc = get_nprocs_conf(); // Configured processors (some can be down...)

(glibc 2.2.5, but i think it keeps working since time ago).

BTW, why linux does not implement sysconf(_SC_NPROC_[CONF,ONLN]) ??

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam1 #1 SMP Sun Apr 7 00:50:05 CEST 2002 i686
