Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUE3K5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUE3K5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUE3K5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:57:24 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63204 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262499AbUE3K5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:57:21 -0400
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 12:57:20 +0200
Message-ID: <xb7aczqb2sv.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Giuseppe" == Giuseppe Bilotta <bilotta78@hotpop.com> writes:

    Giuseppe> So, while we wait for complete support, at the kernel
    Giuseppe> level, for all the multimedia keyboards supported by X,
    Giuseppe> we *need* proper raw mode.

My question is: why do everything inside the kernel?


Even  'khttpd' has  been removed  from  the kernel,  because the  same
efficiency has been achieved in  the *userland* apache module.  Why is
the input layer moving _backwards_?

I  don't think  converting  between keyboard/mouse  protocols and  the
input   system's  "struct   input_event"  has   a   tighter  real-time
requirement  than a  heavily loaded  web  server.  How  many keys  per
second can  you type  at?  (Even  if you type  extremely fast  and the
hardware constraints  (velocity, etc.) are  not reached yet,  there is
still  a  limit that  the  keyboard  controller,  e.g.  i8042,  cannot
exceed.)  How  many mouse movements are  you making per  second?  Is a
userland driver unable  to handle that data rate?   (I don't think so.
I believe enve a 386-DX 33MHz  can handle it with ease.)  If not, then
please do it  in userland, so as not to waste  kernel memory (which is
*NON-swappable*).




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

