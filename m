Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268274AbTBMTj1>; Thu, 13 Feb 2003 14:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268276AbTBMTj1>; Thu, 13 Feb 2003 14:39:27 -0500
Received: from a127-0-0-1.xs4all.nl ([213.84.70.4]:7684 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id <S268274AbTBMTj1>; Thu, 13 Feb 2003 14:39:27 -0500
Date: Thu, 13 Feb 2003 20:49:17 +0100
From: Jurjen Oskam <jurjen@quadpro.stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Accessing the same disk via multiple channels
Message-ID: <20030213194917.GA8479@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

here's something I've been wondering about. On my work, we have
an EMC2 Symmetrix in a SAN environment, with (until now) only
AIX boxes attached to the SAN.

Each server is equipped with 2 FibreChannel cards. The SAN is
configured to present the same disk (which is in fact a virtual
Symmetrix device) over two channels. This means the host sees
two physical devices (as far as that host's concerned) which is
in fact really only one device. In linux terms: /dev/sda and /dev/sdc
are exactly the same disks, but the (standard) OS doesn't know this.

EMC2 provide a piece of software called PowerPath, which takes advantage of
this situation. It provides yet another device (let's say /dev/powersda), which
uses the (identical) native devices /dev/sda and /dev/sdc. If one of those
two would disappear, access to powersda would still be possible.

How does linux as it is now handle the situation of one physical device
presented via multiple paths (without extra software)?

-- 
Jurjen Oskam

PGP Key available at http://www.stupendous.org/
