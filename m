Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135996AbRD0Lvd>; Fri, 27 Apr 2001 07:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbRD0LvX>; Fri, 27 Apr 2001 07:51:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:26362 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135996AbRD0LvC>; Fri, 27 Apr 2001 07:51:02 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010425173210.A13124@vger.timpanogas.org> 
In-Reply-To: <20010425173210.A13124@vger.timpanogas.org>  <20010423163757.D1131@vger.timpanogas.org> <20010423163248.B1131@vger.timpanogas.org> <001d01c0cc33$7e62daa0$5517fea9@local> <3942.988063428@redhat.com> <20010423163248.B1131@vger.timpanogas.org> <4750.988065680@redhat.com> <20010423163757.D1131@vger.timpanogas.org> <4855.988065927@redhat.com> <20010423163954.A1237@vger.timpanogas.org> <4897.988066047@redhat.com> 
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: filp_open() in 2.2.19 causes memory corruption 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Apr 2001 12:50:45 +0100
Message-ID: <5157.988372245@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jmerkey@vger.timpanogas.org said:
> I've gotten to the bottom of this problem, and you are correct that
> klog  is trashing the messages file for the oops.

Oh dear. That's quite a serious bug in klogd. It should never destroy the
original information, _especially_ if the System.map it's looking at
blatantly doesn't match /proc/ksyms.

Have you reported it to your distribution vendor yet?

--
dwmw2


