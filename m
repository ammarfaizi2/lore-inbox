Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270036AbUJTL1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270036AbUJTL1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270113AbUJTL05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:26:57 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:36225 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S270036AbUJTLSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:18:04 -0400
Date: Wed, 20 Oct 2004 13:18:00 +0200
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Instances of visor us devices are not deleted (2.6.9-rc4-mm1)
Message-ID: <20041020111800.GA6569@gamma.logic.tuwien.ac.at>
References: <20041020061647.GA20692@gamma.logic.tuwien.ac.at> <20041020070056.GA15620@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041020070056.GA15620@kroah.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

On Mit, 20 Okt 2004, Greg KH wrote:
> Hm, no it isn't.  Are you sure that userspace doesn't still have the
> device nodes open?  If they do, the ttyUSB number will not be released
> until that happens.

Ah, ok. So the culprit is gnome-pilot listening for HotSync events. 

I thought that as soon as the unit/usb device is disconnected, also the
device numbers are released.

But then: How to cope with problems like this? REcurring plugging and
unplugging and a program listening to this?

Is it possible to have
	/dev/pilot	->	/dev/ttyUSB1
and gnome-pilot opens /dev/pilot. Will then every new hot sync also
create other devices?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
Yesterday it worked.
Today it is not working.
Windows is like that.
                       --- Windows Error Haiku
