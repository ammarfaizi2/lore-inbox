Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCNFax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCNFax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVCNFax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:30:53 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:60077 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261233AbVCNFap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:30:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Date: Mon, 14 Mar 2005 00:30:39 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c2050313210230161278@mail.gmail.com>
In-Reply-To: <a71293c2050313210230161278@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140030.39482.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2005 00:02, Stephen Evanchik wrote:
> Here's the latest patch for TracKPoint devices. I have changed the
> sysfs filenames to be more descriptive for commonly used attributes. I
> also implemented the set_properties flag for initialization.
> 
> It patches against 2.6.11 and 2.6.11.3 however I have not tested it
> with 2.6.11.3 .
> 
> Any comments are appreciated.
> 

Hi Stephen,

It looks very good now, I have just a couple of comments and I as far as
I concerned it is ready for inclusion.

> +PSMOUSE_DEFINE_ATTR(middle_btn_disable);

Is it possible to change it for positive (something like middle_button
which would show 1 for enabled - default - and 0 for disabled). But this
is my personal preference, others may disagree.

> +#define MAKE_ATTR_WRITE(_item, command) \
> +	static ssize_t psmouse_attr_set_##_item(struct psmouse *psmouse,
> const char *buf, size_t count) \

It looks like your mailer has wrapped the patch.

Also the patch has some trailing whitespace. If you are using vim the
foillowing in .vimrc will show all trailing spaces in all their glory:

highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/

-- 
Dmitry
