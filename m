Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRHAJkG>; Wed, 1 Aug 2001 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRHAJj5>; Wed, 1 Aug 2001 05:39:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:41717 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266150AbRHAJjt>; Wed, 1 Aug 2001 05:39:49 -0400
Message-ID: <3B67CE6A.A670093E@redhat.com>
Date: Wed, 01 Aug 2001 10:39:54 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet> <200107311757.f6VHvWH01678@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet> you write:
> >
> >Isn't SMP P6 kernel supposed to boot fine on a P4? Btw, booting with
> >"nosmp" works but booting with "noapic" hangs just the same.
> 
> It should boot, and it looks like the problem may be a bad MP table.

Oh it is. And it's due to a recommendation Intel makes to bios writers. 
As a result, every P4 I've encountered shares this bug. Intel knows it's
an invalid MP table, but refuses to change the recommendation.

Now all Linux installers that decide to install a SMP kernel if they
encounter
a MPTABLE already have a "except if it's a P4" exception nowadays..

Greetings,
   Arjan van de Ven
