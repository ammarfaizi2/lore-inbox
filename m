Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDHLcj>; Sun, 8 Apr 2001 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDHLca>; Sun, 8 Apr 2001 07:32:30 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:20663 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132536AbRDHLcV>; Sun, 8 Apr 2001 07:32:21 -0400
From: Christoph Rohland <cr@sap.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-ac2 -- How do I determine if shm is being used?
In-Reply-To: <3ACF5C31.B3B0594F@megapathdsl.net>
Organisation: SAP LinuxLab
In-Reply-To: <3ACF5C31.B3B0594F@megapathdsl.net>
Message-ID: <m3hezzr35y.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 08 Apr 2001 14:31:47 +0200
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

On Sat, 07 Apr 2001, Miles Lane wrote:
> I have mounted:
> 
> 	none on /var/shm type shm (rw)

Not necessary any more.

> 	tmpfs on /dev/shm type tmpfs (rw)

Also not necessary, but recommended for POSIX shm. BTW it will not
work with Linus' kernel. Type "shm" is supported by both versions.

> X Error of failed request: BadValue (integer parameter out of range
> for operation)
>   Major opcode of failed request:  146 (MIT-SHM)
>   Minor opcode of failed request:  3 (X_ShmPutImage)
>   Value in failed request:  0x1600001
>   Serial number of failed request:  35107
>   Current serial number in output stream:  35111

Ubfortunately this does not tell what it wanted to do.

> I'd like to check to make sure that shm is actually accessible
> to my programs.  Is there any easy way to do this?

ipcs should be your friend. Especially 'ipcs -lm'.

Greetings
		Christoph


