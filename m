Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423024AbWAMWZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423024AbWAMWZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423025AbWAMWZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:25:07 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:29550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423024AbWAMWZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:25:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVQ9F+VdNqW5sQg1vx4bx0CSARkbEOZ+o72YGiCWuhKyILjY9cwSKYfGyU5qVWAMSvti51iIXNAi9sPIdw2D382SERtxS/f/su79mOnw7DnCigzpbbnGVMe0YYEc2erW3Kyy20drJRm+fCoOHR9RpSicBViIisyhRdgA502mRnE=
Message-ID: <d120d5000601131425m729e7aa5vc36fce77b09e33c1@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:25:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1137190444.4854.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051225212041.GA6094@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112000830.GB10142@hansmi.ch>
	 <200601122312.05210.dtor_core@ameritech.net>
	 <1137189319.4854.12.camel@localhost.localdomain>
	 <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
	 <1137190444.4854.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
> > or just "fnkeyfirst and fnkeyast"?
>
> I think "no translation" should still be around if people want to handle
> it entirely from userland no ?
>
> That is:
>
>  - no translation : nothing special is done, Fx sends Fx keycode
> regardless of Fn key, Fn key itsef sends a keycode for itself, there is
> no emulation of numlock
>
>  - fnkeyfirst / fnkeylast : Either Fx is translated and Fn-Fx is not or
> the opposite. Numlock emulation is enabled.

OK then, I will push the patch to Linus.

--
Dmitry
