Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVBBVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVBBVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVBBVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:21:11 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:20548 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262792AbVBBVRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:17:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o+kyuPJuIB2nCmAvViAFrznyFytzq2BKwe474kgZn3iGxQzQFy0FxM9B+mt8rCWE95eceSj9GbN9aJ9FXu2zPoC6rtA67Vx/nsWclraHb/T5wWnLhZa8chflhXm+bVMwwxNSMATuaFK7wMoLmVDu+E6WCMj6G5IOa563YT+iBm0=
Message-ID: <d120d50005020213176eab546a@mail.gmail.com>
Date: Wed, 2 Feb 2005 16:17:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <m3lla64r3w.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123190109.3d082021@localhost.localdomain>
	 <m3acqr895h.fsf@telia.com>
	 <20050201234148.4d5eac55@localhost.localdomain>
	 <m3lla64r3w.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 13:07:21 -0800 (PST), Peter Osterlund
<petero2@telia.com> wrote:
> +                               if (mousedev->pkt_count >= 2) {
> +                                       tmp = ((fx(0) - fx(2)) * (250 * FRACTION_DENOM)) / size;
> +                                       tmp += mousedev->frac_dx;
> +                                       mousedev->packet.dx = tmp / FRACTION_DENOM;
> +                                       mousedev->frac_dx = tmp - mousedev->packet.dx * FRACTION_DENOM;
> +                               }

What about setting scale to 256 and fractions to 128 - that should
save some cycles? Or it will be too much?

-- 
Dmitry
