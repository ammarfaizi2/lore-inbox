Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWGJQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWGJQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422691AbWGJQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:45:58 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:65127 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422690AbWGJQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:45:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uc2zszm5w/V43crga33+MQOe/fw60PxatEkbGLMj2PyXC0CM8FSHgFq01E5+pTWOxvKHcu0O3XS19bobUBWize7aeHIpbcclgIQXlFatNVkOeP9eFZLhUKrPGLbu6SAT10ldD293e5UkRIsGsmOgYooj+iPg/5ciieClcBDX+k0=
Message-ID: <62b0912f0607100945o574dcce8w8f734e5828bdcaa8@mail.gmail.com>
Date: Mon, 10 Jul 2006 18:45:57 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
Cc: linux-kernel@vger.kernel.org, linux.nics@intel.com
In-Reply-To: <44B2716A.3030009@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>
	 <44B2716A.3030009@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> If you have received a motherboard or card with a broken EEPROM then your card
> is in a limbo state - it might work but results are unreliable and may cause
> your entire system to break (and even data corruption).
>
> You should contact the hardware vendor and have the board replaced or upgraded
> with a proper EEPROM. Continuing to work with the corrupted EEPROM image that
> you have now can seriously hurt you later on.

Every single IP130 I've had my hands on has had an EEPROM that the
Linux driver declared bad.

I'm afraid that it's not the board that's at fault, it's the driver.

The NICs are working perfectly.

(Also, it seems mighty odd to refuse to drive the hardware based on an
EEPROM checksum failure, when the e100 driver will happily load for a
device where for example IRQ routing is broken.  Just another
indication that erroring out in this situation is overkill.)
