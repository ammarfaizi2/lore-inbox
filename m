Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULWBtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULWBtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 20:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULWBtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 20:49:11 -0500
Received: from THUNK.ORG ([69.25.196.29]:42912 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261172AbULWBsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 20:48:54 -0500
Date: Wed, 22 Dec 2004 20:45:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rob Browning <rlb@defaultvalue.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041223014527.GA25558@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Rob Browning <rlb@defaultvalue.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de> <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org> <20041220062055.GA22120@one-eyed-alien.net> <20041219223723.3e861fc5@lembas.zaitcev.lan> <87u0qepxd3.fsf@trouble.defaultvalue.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0qepxd3.fsf@trouble.defaultvalue.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 02:10:00AM -0600, Rob Browning wrote:
> The sample Kconfig warnings I saw posted later in this thread would
> certainly have given enough information to know to avoid the driver,
> though if true, this might be even clearer:
> 
>   Note: this driver does not coexist well with usb-storage, and
>   usb-storage is is often the best driver for common devices like
>   external drive enclosures.  At the moment, usb-storage may peform
>   dramatically better for those devices.
> 
>   If you're not certain you need this driver, you should probably
>   say 'N' here, and choose usb-storage instead.

The other caveat which is worth adding is that currently, the UB
device only supports a single LUN.  Some devices, most notably USB
readers that support multiple types of compact flash/secure
digital/smart media/et.al., and the PalmOne T5 PDA export multiple
LUN's.  

(I was scratching my head for a while trying to figure out why the T5
documentation claimed that you could access both the internal flash
memory as well as the Secure Digital external memory via the USB
interface until I realized it was because I was using the UB driver,
and it didn't support multiple LUN's.)

						- Ted
