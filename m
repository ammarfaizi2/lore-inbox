Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSHJJro>; Sat, 10 Aug 2002 05:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHJJro>; Sat, 10 Aug 2002 05:47:44 -0400
Received: from aba.krakow.pl ([62.233.163.30]:55460 "HELO two.aba.krakow.pl")
	by vger.kernel.org with SMTP id <S316753AbSHJJrn>;
	Sat, 10 Aug 2002 05:47:43 -0400
Date: Sat, 10 Aug 2002 11:51:26 +0200
From: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
To: zhengchuanbo <zhengcb@netpower.com.cn>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: about the tuning of eepro100
Message-ID: <20020810095126.GF21239@aba.krakow.pl>
References: <200208101742654.SM00824@zhengcb>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200208101742654.SM00824@zhengcb>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 05:38:39PM +0800, zhengchuanbo wrote:

> so i think the limit is at the eepro100 card. is there any way to improve the throughput? or someone got a higher throughput then that?
> the eepro100 chip is 82559.

Use e100 driver from Intel [1] with the following parameters:

insmod e100.o BundleSmallFr=1 IntDelay=0x600 ucode=1

Intel's driver supports all the interrupt saving features (interrupt
delay and small packet bundling) present in EEPro/100 cards. The driver
is now GPL, so it should get back to the mainstream kernel.

[1] http://downloadfinder.intel.com/scripts-df/Detail_Desc.asp?ProductID=417&DwnldID=2896

-- 
Pawe³ Krawczyk, Kraków, Poland  http://echelon.pl/kravietz/
crypto: http://ipsec.pl/
horses: http://kabardians.com/
