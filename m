Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSAUWVy>; Mon, 21 Jan 2002 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSAUWVo>; Mon, 21 Jan 2002 17:21:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6321 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288747AbSAUWVb>;
	Mon, 21 Jan 2002 17:21:31 -0500
Date: Mon, 21 Jan 2002 14:19:31 -0800 (PST)
Message-Id: <20020121.141931.105134927.davem@redhat.com>
To: andrea@suse.de
Cc: reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020121175410.G8292@athlon.random>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>
	<20020121175410.G8292@athlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Mon, 21 Jan 2002 17:54:10 +0100
   
   correct, furthmore it cannot even trigger if you invlpg with an address
   page aligned (4mbyte aligned in this case) like we would always do in
   linux anyways, we never use invlpg on misaligned addresses, no matter if
   the page is a 4M or a 4k page.

That's not true, see the ptrace() helper code.  Russell King pointed
this out to me last week and it's on my TODO list to fix it up.

