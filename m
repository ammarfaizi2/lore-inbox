Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVAZOGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVAZOGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVAZOGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:06:23 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:24963 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262302AbVAZOFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:05:33 -0500
Date: Wed, 26 Jan 2005 15:05:09 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Greg KH <greg@kroah.com>, Aurelien Jarno <aurelien@aurel32.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien)
Message-ID: <20050126140509.GB23182@speedy.student.utwente.nl>
Mail-Followup-To: Shawn Starr <shawn.starr@rogers.com>,
	Greg KH <greg@kroah.com>, Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org
References: <200501260249.23583.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501260249.23583.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 02:49:23AM -0500, Shawn Starr wrote:
>  static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
>  {
> - if (rpm == 0)
> + if (rpm <= 0)
The rpm parameter is unsigned so this change is useless. The rest makes sense
to me.

BTW, can anyone tell me why the uints in this parameter list are declared as
'unsigned' and not as 'unsigned int'?

    Sytse
