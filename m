Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTKXDC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 22:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTKXDC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 22:02:58 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:31629 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261217AbTKXDC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 22:02:57 -0500
Date: Sun, 23 Nov 2003 21:57:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Frank Dekervel <kervel@drie.kotnet.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Message-ID: <20031123215717.GD30835@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Frank Dekervel <kervel@drie.kotnet.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200311191749.28327.kervel@drie.kotnet.org> <200311201137.55553.kervel@drie.kotnet.org> <20031120072236.68327dca.akpm@osdl.org> <200311221850.36503.kervel@drie.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311221850.36503.kervel@drie.kotnet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 06:50:36PM +0100, Frank Dekervel wrote:
> hello
> 
> something similar:
> 
> catting /proc/bus/pnp/devices makes my system oops, doing it twice makes my 
> system crash :p
> 
> the oops looks very much like the oops (also bad EIP value, also no stack 
> trace) i get on boot with the first patch (below) applied. As i already 
> mailed, i need to revert that patch to make my system boot.
> 
> this oops happens with all 3 patches below reverted, so i guess it'll happen 
> too with stock test9.
> 
> would the -mm5 pnp-fix-4.patch be worth a try ? it seems related
>
> thanks,
> greetings,
> frank

Hi,

Thanks for the testing.  I don't think pnp-fix-4.patch should affect this problem.
I will probably be creating a blacklist for PnPBIOS systems that have this bug.
Currently, I'm waiting to see if reading static resources has any positive affects
on some additional systems.  If not then I may switch back to the the original
behavior.  DMI information for your system would be helpful.

Thanks,
Adam
