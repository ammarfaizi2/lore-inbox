Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbTGTXrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268925AbTGTXrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:47:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38629
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268714AbTGTXrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:47:31 -0400
Subject: Re: [Fwd: Re: Kernel 2.4 CPU Arch issues]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "William M. Quarles" <quarlewm@jmu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1B25C2.8010403@jmu.edu>
References: <3F1B25C2.8010403@jmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2003 01:00:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-21 at 00:29, William M. Quarles wrote:
> Well, you separated the Pentium and Pentium-MMX.  It's the exact same
> difference between Pentium Pro and Pentium-II: MMX technology.  That's
> the point.

This makes no difference to the kernel. Splitting PPro would only make
sense for one reason. The Pentium Pro needs store barriers on
spin_unlock and friends, the PII and later do not. However if this was
done you'd also want to check for PPro boots with a PII kernel and panic
which isn't currently done

