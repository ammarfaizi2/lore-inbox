Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLDWip>; Mon, 4 Dec 2000 17:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLDWif>; Mon, 4 Dec 2000 17:38:35 -0500
Received: from 213.237.11.204.adsl.vbr.worldonline.dk ([213.237.11.204]:20793
	"HELO 213.237.11.204.adsl.vbr.worldonline.dk") by vger.kernel.org
	with SMTP id <S129410AbQLDWiR>; Mon, 4 Dec 2000 17:38:17 -0500
To: linux-kernel@vger.kernel.org
Path: news.storner.dk!not-for-mail
From: henrik@storner.dk (Henrik Størner)
Newsgroups: linux.kernel
Subject: Re: 2.4.0-test12pre4: parport / lp problems
Date: 4 Dec 2000 23:07:48 +0100
Organization: Linux Users Inc.
Message-ID: <90h4jk$18l$1@osiris.storner.dk>
In-Reply-To: <20001204213348.A932@storner.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <20001204213348.A932@storner.dk> Henrik Størner <henrik@storner.dk> writes:

>I discovered yesterday that printing does not work in 2.4.0-test12-pre4.

OK - mea culpa. It turned out to be a configuration problem: I had
been playing with the I2C support for lm_sensors, and in my attempt to
get it working I had apparently enabled an I2C driver that grabbed the
parport0 device before lp could get at it.

After turning off the I2C support, my printer is working again.

Sorry for the false alarm.


Henrik
-- 
Henrik Storner      | "Crackers thrive on code secrecy. Cockcroaches breed 
<henrik@storner.dk> |  in the dark. It's time to let the sunlight in."
                    |  
                    |          Eric S. Raymond, re. the Frontpage backdoor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
