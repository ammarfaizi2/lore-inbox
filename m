Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUIUPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUIUPeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIUPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:34:23 -0400
Received: from imap.gmx.net ([213.165.64.20]:24993 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267765AbUIUPeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:34:22 -0400
X-Authenticated: #271361
Date: Tue, 21 Sep 2004 17:34:04 +0200
From: Edgar Toernig <froese@gmx.de>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] inotify 0.9.2
Message-Id: <20040921173404.0b8795c9.froese@gmx.de>
In-Reply-To: <1095744091.2454.56.camel@localhost>
References: <1095652572.23128.2.camel@vertex>
	<1095744091.2454.56.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
>
> +/*
> + * struct inotify_event - structure read from the inotify device for each event
> + *
> + * When you are watching a directory, you will receive the filename for events
> + * such as IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, and so on ...
> + *
> + * Note: When reading from the device you must provide a buffer that is a
> + * multiple of sizeof(struct inotify_event)
> + */
>  struct inotify_event {
>  	int wd;
>  	int mask;
> -	char filename[256];
> +	char filename[PATH_MAX];
>  };

You really want to shove >4kB per event to userspace???

Ciao, ET.
