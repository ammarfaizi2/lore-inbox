Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTJOTNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTJOTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:13:04 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30475 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264089AbTJOTND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:13:03 -0400
Date: Wed, 15 Oct 2003 21:13:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver fixes for 2.6.0-test7
Message-ID: <20031015191300.GA11752@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <10662411473410@kroah.com> <10662411472283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10662411472283@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:05:47AM -0700, Greg KH wrote:
> -device_create_file(&client->dev, &dev_attr_in_max##offset);
> +device_create_file(&client->dev, &dev_attr_in_max##offset); \
> +} while (0);
              ^
Did you really want to have that ';' there?
It is harmless in current usage, but it may be confusing.

	Sam
