Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKGEq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTKGEq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:46:57 -0500
Received: from web20903.mail.yahoo.com ([216.136.226.225]:6693 "HELO
	web20903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261406AbTKGEqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:46:55 -0500
Message-ID: <20031107044652.2325.qmail@web20903.mail.yahoo.com>
Date: Thu, 6 Nov 2003 20:46:52 -0800 (PST)
From: Brandon Stewart <rbrandonstewart@yahoo.com>
Subject: Re: 2.6.0-test9-mm1 and mm2: Extremely slow mouse
To: linux-kernel@vger.kernel.org
Cc: Bob Gill <gillb4@telusplanet.net>, Eric Sandall <eric@sandall.us>
In-Reply-To: <20031107014720.28888.qmail@web20902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple solution. Add psmouse_resolution=200 to the boot options. No skip,
smooth mouse. All is good.

image=/boot/vmlinuz-2.6.0-test9-mm2
        label=260-test9-mm2
        root=/dev/hda5
        read-only
        append=" devfs=mount acpi=on resume=/dev/hda1 psmouse_resolution=200"
        initrd=/boot/initrd-2.6.0-test9-mm2.img

-Brandon

--- Brandon Stewart <rbrandonstewart@yahoo.com> wrote:
> On 2.6.0-test9, sliding my finger from the left of the touchpad to the right
> takes the cursor 3/4 of the way across the screen on a 1024x768 resolution.
> Doing the same on 2.6.0-test9-mm1 & 2.6.0-test9-mm2 moves the mouse only
> about
> 30 pixels, or about 1/33 of the way across the screen. It is exactly the same
> system, with exactly the same configuration. The only difference is the
> kernel
> ....
> -Brandon
