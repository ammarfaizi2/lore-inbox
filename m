Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSIEREG>; Thu, 5 Sep 2002 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSIEREF>; Thu, 5 Sep 2002 13:04:05 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:59891 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S317872AbSIERED>; Thu, 5 Sep 2002 13:04:03 -0400
From: Christoph Rohland <cr@sap.com>
To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Cc: linux-kernel@vger.kernel.org, linus@transmeta.com,
       vakatov@ncbi.nlm.nih.gov
Subject: Re: BUG:: SYSV IPC shmem reported as "(deleted)" in process maps
 file
References: <3D6FDFF8.C0D86A3C@ncbi.nlm.nih.gov>
	<3D6FE07C.B76DD4B6@ncbi.nlm.nih.gov>
Organisation: Development SAP J2EE Engine
Date: Thu, 05 Sep 2002 19:08:19 +0200
In-Reply-To: <3D6FE07C.B76DD4B6@ncbi.nlm.nih.gov> (Anton Lavrentiev's
 message of "Fri, 30 Aug 2002 17:15:40 -0400")
Message-ID: <it1kgy9o.fsf@sap.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Common Lisp
 (Windows [3]), i586-pc-win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Fri, 30 Aug 2002, Anton Lavrentiev wrote:
> cat /proc/#/maps:
> 40018000-40022000 rw-s 00000000 00:05 5865476    /SYSV01315549 (deleted)
> 4021b000-40225000 rw-s 00000000 00:05 5898248    /SYSV012cc3bc (deleted)
> 
> ipcs -a:
> 0x01315549 5865476    ncbiduse  666        40960      1
> 0x012cc3bc 5898248    ncbiduse  666        40960      1

Works as designed. 

The internal implementation creates the file unlinked. SYSV is one
holder of this open file. The display may be irritating but IMHO its
internal simplicity is worth to live with it.

Greetings
		Christoph


