Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVBBWGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVBBWGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVBBWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:06:34 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:38555 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262806AbVBBWGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:06:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GjS/U/S8E27q7edzCvydfPCSAkEWCH6pRx2GtTncWf20JfZhqORtYO5YcLnNGru6019Rvc38xEsKrYrTkxyZHrIdIpezomLyLGXDM8DXes2ARe4KLrYW6CacefHX6UyXGucaPw8cXldy5FPG6EAzr51IxQCf6VqTBFweCPFJePw=
Message-ID: <d120d50005020214066c1249a2@mail.gmail.com>
Date: Wed, 2 Feb 2005 17:06:09 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <m31xby3a81.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123190109.3d082021@localhost.localdomain>
	 <m3acqr895h.fsf@telia.com>
	 <20050201234148.4d5eac55@localhost.localdomain>
	 <m3lla64r3w.fsf@telia.com> <d120d50005020213176eab546a@mail.gmail.com>
	 <m31xby3a81.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 13:52:03 -0800 (PST), Peter Osterlund
<petero2@telia.com> wrote:
> 
>        if (mousedev->touch) {
> +               size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> +               if (size == 0) size = xres;

Sorry, missed this piece first time around. Since we don't want to
rely on screen size anymore I think we should set size = 256 *
FRACTION_DENOM / 2 if device limits are not set up to just report raw
coords. What do you think?

-- 
Dmitry
