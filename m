Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276381AbRJGOdv>; Sun, 7 Oct 2001 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276384AbRJGOdl>; Sun, 7 Oct 2001 10:33:41 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:56452 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S276381AbRJGOd1>; Sun, 7 Oct 2001 10:33:27 -0400
Message-ID: <3BC067BB.73AF1EB5@welho.com>
Date: Sun, 07 Oct 2001 17:33:31 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> There are idle tasks per CPU. If there are runnable tasks and the
> idle-task of a CPU is running it, it is not fully loaded at this
> time.
> 
> No idle task is running, if all CPUs are fully loaded AFAIR.

Yes. However, you still want to balance the queues even if all CPUs are
100% utilized. It's a fairness issue. Otherwise you could have 1 task
running on one CPU and 49 tasks on another.

	MikaL
