Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVIFSrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVIFSrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIFSrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:47:13 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:45842 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVIFSrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:47:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GTFn7fyFQrWg7sJQle50pGzIe9adQhr5Vi0yf2Hk71/Yw5RwjDMlAQXpp3ie+XMoPfa390em7vtg0/auUYNwejSJEP6jzC6l+xBF9vdkoUq9FqsPtmrdAn2dtyhp49NcHWTffJ0FPYQiihAnV5WQbs4KEYcKfqZoRDF4KLtZsuE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: [PATCH] wrong firmware location in IPW2100 Kconfig entry   (Was: IPW2100 Kconfig)
Date: Tue, 6 Sep 2005 20:48:29 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com, Roman Zippel <zippel@linux-m68k.org>,
       Sam Ravnborg <sam@ravnborg.org>
References: <005101c5b311$4ca69a50$a20cc60a@amer.sykes.com>
In-Reply-To: <005101c5b311$4ca69a50$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509062048.29495.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 20:32, Alejandro Bonilla wrote:
> Hi,
> 
> 	I checked the IPW2100 in the current git from linux-2.6 and the menuconfig
> help (Kconfig) says you need to put the firmware in /etc/firmware, it should
> be /lib/firmware.
> 
> Who should I send the "patch" to? Or can someone simply change that?
> 

Firmware should go into /lib/firmware, not /etc/firmware.

Found by Alejandro Bonilla.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/wireless/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-mm1-orig/drivers/net/wireless/Kconfig	2005-09-02 23:59:51.000000000 +0200
+++ linux-2.6.13-mm1/drivers/net/wireless/Kconfig	2005-09-06 20:39:45.000000000 +0200
@@ -152,7 +152,7 @@
 	  In order to use this driver, you will need a firmware image for it.
           You can obtain the firmware from
 	  <http://ipw2100.sf.net/>.  Once you have the firmware image, you 
-	  will need to place it in /etc/firmware.
+	  will need to place it in /lib/firmware.
 
           You will also very likely need the Wireless Tools in order to
           configure your card:


