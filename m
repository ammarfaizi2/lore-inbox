Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDXOv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDXOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDXOv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:51:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:61974 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWDXOv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:51:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m64YWt+7ORhbbULA/6aEJxiManFmGIpVM6ub8iXHyCQWpp1b8Bu6lWuwukiuo9qdb7B8JHgpfYlGNRpluKYlTyF1UwAPwtVtX0+fKJ3wlrRZ+Kki7PDhlQZ1IdOuse/a2XyDWo5NiPU2BUjU3ElbctwU6sqyJUQBRdsWQYE5niw=
Message-ID: <d120d5000604240751y7501d376p62904e149ccbf4b3@mail.gmail.com>
Date: Mon, 24 Apr 2006 10:51:27 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Cc: "Yu, Luming" <luming.yu@intel.com>,
       "Alexey Starikovskiy" <alexey_y_starikovskiy@linux.intel.com>,
       "Xavier Bestel" <xavier.bestel@free.fr>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060420215549.GA2352@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
	 <20060420215549.GA2352@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> Having EV_ACPI might make sense for thermal/battery events, but not
> for normal keys.

No, I do not want EV_ACPI at all. If it does not map to standard
key/button/switch abstraction it really does not belong in input
layer. There could be a "battery" or "power" layers providing
abstraction for ACPI/APM/whateverfor that kind of stuff, but not input
layer.

But KEY_SLEEP, KEY_POWER, etc are more than welcome.

--
Dmitry
