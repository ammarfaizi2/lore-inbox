Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRKOCvj>; Wed, 14 Nov 2001 21:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280339AbRKOCv2>; Wed, 14 Nov 2001 21:51:28 -0500
Received: from anime.net ([63.172.78.150]:15371 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S280323AbRKOCvO>;
	Wed, 14 Nov 2001 21:51:14 -0500
Date: Wed, 14 Nov 2001 18:50:06 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: <sensors@stimpy.netroedge.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [lm_sensors] hard lockup on modprobe w83781d with Tyan Dual
 K7/Thunder
In-Reply-To: <20011114215215.0692E1097@shrek.lisa.de>
Message-ID: <Pine.LNX.4.30.0111141847300.31580-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Hans-Peter Jansen wrote:
> fan1:     7180 RPM  (min = 3000 RPM, div = 2)                       <3590>
> fan2:     7105 RPM  (min = 3000 RPM, div = 2)                       <3515>

Fan divisor is wrong.
adjust /proc/sys/dev/sensors/w83782d-i2c-0-2d/fan_div as needed.

> temp1:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor
> <46°C>
> temp2:    +76.5°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor
> <41°C>
> temp3:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor
> <46°C>

thermistor type is wrong.

echo "2" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/sensor{1..3}

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

