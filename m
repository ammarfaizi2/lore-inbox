Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUF1AWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUF1AWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUF1AWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:22:30 -0400
Received: from 203-217-29-35.perm.iinet.net.au ([203.217.29.35]:60120 "EHLO
	anu.rimspace.net") by vger.kernel.org with ESMTP id S264569AbUF1AW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:22:28 -0400
To: Petter Larsen <pla@morecom.no>
Cc: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mode data=journal in ext3. Is it safe to use?
In-Reply-To: <1088345837.5288.1.camel@pla.lokal.lan> (Petter Larsen's
 message
	of "Sun, 27 Jun 2004 16:17:17 +0200")
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	<1087322976.1874.36.camel@pla.lokal.lan>
	<40D06C0B.7020005@techsource.com>
	<1087460983.2765.34.camel@pla.lokal.lan>
	<87wu26mto2.fsf@enki.rimspace.net>
	<1088345837.5288.1.camel@pla.lokal.lan>
From: Daniel Pittman <daniel@rimspace.net>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEUnIyatfG0aGBsMChBG
 NThoSkb52Lk0unwsAAACeElEQVR42l2UMZPbIBCF9zDqw4xRzYDTO5LTY92SWsyx11NE//8n5AGK
 LxMVtkcfb/fxWEzr61nWfx8aX57CnVUI/wPNRQH41Ycv4PGZJEZ/25pSjbKeXLwsTkrimArWeNdb
 eU+aNzVJkkJlJ78uzvu/IGqRImXnElHHkQ/BAzjUEBErPhXyS3CMtwvAQuhgjOzJGFOCd5p8e/Dp
 JOWS7HwchynK3QhtwgrwvXAqn+39Ua9818qBLAConbi/P6ot5Iiol6JiSZ51ACMNIAIodLJ0zccJ
 bKQGoKD4vN7EvMBO5AbgXCaxx6sUnXZTEZuSGc0RAXoMhUi6NlDBbJEdqbrY7L5ABogqOkfq3hXY
 tEx1NnIcNttyQ4qqKcqe0ANdcwPGbHB72tW2vFVT52YKoVBs8a6kI0t5M6fbw1iKEIRATCmlt3lk
 aGaTS3F9HxwLjI39/c4ZgHyLl5gZvnopA1fW7IgKW8SZ48jN6GEyfO3DFmmNI5/PEA1qkRs9HLOk
 ExgLLbkRoiMt3EtVjIQY63T8As98KrL5hp2No/Vaokg9JeitmakpFKF7qafEREwGx35cjlOSsXWD
 RLg/DeAnDNcTRKzvxLfBivx5wBiyv7YO1Ir5VivSPNzmK1JVRHqMBKKHp6NKls31Imi+NAnxOTzb
 eiflOhi3IfWt292HRfWVDQS/3g09MQ60qXVRWIfUGwjhh2h+ME9aPeIYxBYJrnbe9g0zqLegY5/D
 BqBc6nvC9b+Jv3B0uPodtEr2AvuF9zvxhhDfcW+bImR7wXlNMdBPxkWjfe0K/6hWuYlZT2ihMNUp
 4r9kWcKvanWOj+2DAkeFE0xpD38AQw3cf9DOFKYAAAAASUVORK5CYII=
Date: Mon, 28 Jun 2004 10:22:17 +1000
Message-ID: <873c4g1qh2.fsf@enki.rimspace.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2004, Petter Larsen wrote:
>>> We are using ext3 on a compact flash disk in an embedded device. So we
>>> are not using RAID systems.
>>
>> Watch out - even with the internal wear leveling the CF disk will do,
>> ext3 is still a pretty heavy filesystem to use there.
>
> Well, which filesystem would you then used for read-write on this CF?

My recommendation would be to look at running your system out of memory,
and writing back to flash on a scheduled basis, and at shutdown.

That way the write load is minimized, but you still have a persistent
store.
        Daniel
-- 
Anyone who goes to a psychiatrist ought to have his head examined.
        -- Samuel Goldwyn
