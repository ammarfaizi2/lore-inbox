Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbUJaGte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUJaGte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJaGtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:49:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1443 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261402AbUJaGt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:49:28 -0500
Date: Sun, 31 Oct 2004 07:49:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <20041030222720.GA22753@hockin.org>
Message-ID: <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
 <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041030222720.GA22753@hockin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmm probably some bloat-detection tools would be helpful,
>> like "show me source_lines/object_size ratios of fonctions in
>> this ELF object file". Those with low ratio are suspects of
>> excessive inlining etc.

Hm, I've got a (very simple) line determining utility,
http://linux01.org:2222/f/UHXT/bin/sourcefuncsize
maybe someone can pipe it together with ls -l or whatever.

>The problem with apps of this sort is the multiple layers of abstraction.
>
>Xlib, GLib, GTK, GNOME, Pango, XML, etc.

At least they know one thing: that thou should not stuff everything into one
.so but multiple ones (if it's a lot). That /may/ reduce the size-in-memory,
because not all .so's need to be loaded. OTOH, most apps load /all/ anyway.
Heh, there we go.

>Bloat is cause by feature creep at every layer, not just the app.

I sense Java and C# being the best example.


Z Smith wrote:
>Or join me in my effort to limit bloat. Why use an X server
>that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
>of code with very minimal kmallocing?

FBUI does not have 3d acceleration?

Ken Moffat wrote:
>>The point is that -Os is *much* less tested
>>than -O2 at the moment.

>Because people suck, and don't use it and hence test it.

I doubt even the -O2-only-people use gprof/gcov frequently. :(



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
