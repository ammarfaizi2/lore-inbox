Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbUKCMk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUKCMk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUKCMk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:40:58 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:30986 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S261577AbUKCMkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:40:51 -0500
Subject: Re: patch for sysfs in the cyclades driver
From: Germano <germano.barreiro@cyclades.com>
Reply-To: germano.barreiro@cyclades.com
To: greg@kroah.com
Cc: Scott_Kilau@digi.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: text/plain
Organization: Cyclades Latin America
Message-Id: <1099487348.1428.16.camel@tsthost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 03 Nov 2004 11:09:08 -0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I will have to study again the code I tried first (it was long ago), but
the main problem was that due to that class be (somehow) derived from
class_simple, I can one export using it the major and minor numbers for
the device. Tosatti, maybe you can complete my answer with details,
since it was you that advised me about this limitation.
However, this was some time ago (kernel 2.6.7 was going to be released),
and I didn't check how much sysfs for the tty drivers has changed since
them. If I can attach this data (signalling states) to the port, it
would be very preferable than attaching to the board as me and Scott are
trying. Even because his advise about the possibility of my patch be
overwritting one channel data with other's make a lot of sense and I
will have to test it (I'm grateful for you, Scott).

Cheers :)
Germano

On Tue, Nov 02, 2004 at 02:51:33PM -0600, Kilau, Scott wrote:
> > I know you have done work on USB serial drivers with devices with
> > multiple ports...
> > Is there any way to create a file in sys that can point back to a port,
> > and NOT the port's
> > parent (ie, the board) WITHOUT having to create a new kobject per port?
What's wrong with the kobject in /sys/class/tty/ which has one object
per port?  I think we might not be exporting that class_device
structure, but I would not have a problem with doing that.

thanks,

greg k-h


