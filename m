Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVJ2Oy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVJ2Oy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVJ2Oy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:54:26 -0400
Received: from sender-01.it.helsinki.fi ([128.214.205.139]:33975 "EHLO
	sender-01.it.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751172AbVJ2OyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:54:25 -0400
Date: Sat, 29 Oct 2005 17:54:21 +0300 (EEST)
From: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
X-X-Sender: jmoheikk@rock.it.helsinki.fi
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
In-Reply-To: <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi>
Message-ID: <Pine.OSF.4.61.0510291749360.404250@rock.it.helsinki.fi>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
 <p73vezhtkpy.fsf@verdi.suse.de> <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
 <200510291201.06613.ak@suse.de> <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Janne M O Heikkinen wrote:

> No, I get same panics with numa=noacpi or even with numa=off. If I compile
> 2.6.14 kernel without CONFIG_ACPI_NUMA it does boot.

It wasn't removing of CONFIG_ACPI_NUMA that made it boot after all, I had
also changed memory model from "Sparse" to "Discontiguous". And now
when I recompiled with CONFIG_ACPI_NUMA=y and with "Discontiguous" memory
model it booted just fine.
