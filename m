Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQL0SVx>; Wed, 27 Dec 2000 13:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbQL0SVo>; Wed, 27 Dec 2000 13:21:44 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64994 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129568AbQL0SV2>; Wed, 27 Dec 2000 13:21:28 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>
Message-ID: <m3ito5agyc.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 27 Dec 2000 18:54:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 27 Dec 2000, Christoph Rohland wrote:
> > The following patchlet bring the handling of shmget with size zero
> > back to the 2.2 behaviour. There seem to be programs out, which
> > (erroneously) rely on this.
> 
> Just curiosity: do you know if any specification (POSIX?) defines this
> behaviour? 

I don't think so. IMNSHO it is not legal to call shmget with size <
SHMMIN. But there are programs which do that successfully on Linux
2.2. And I learnt not to break them without reason.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
