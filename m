Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbQKCL4q>; Fri, 3 Nov 2000 06:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130101AbQKCL4g>; Fri, 3 Nov 2000 06:56:36 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:272 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129440AbQKCL4b>; Fri, 3 Nov 2000 06:56:31 -0500
Message-ID: <3A02A7EA.B77CBC5@Hell.WH8.TU-Dresden.De>
Date: Fri, 03 Nov 2000 12:56:26 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Vitali Lieder <vitali@physik.TU-Berlin.DE>
CC: linux-kernel@vger.kernel.org
Subject: Re: NVdriver with new 2.4.test10 not function
In-Reply-To: <Pine.BSF.4.05.10011031047220.62364-100000@rosa.physik.TU-Berlin.DE>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitali Lieder wrote:
> 
> Hallo.
> 
> Ich have test new NVdriver 0.95 with new kernel 2.4.0test10, but
> have the output:
> ***unresolved symbols in /lib/modules/2.4.0-test10/video/NVdriver

Just add the following lines somewhere on top of nv.c and recompile
the nvidia module.

#define mem_map_inc_count(p) atomic_inc(&(p->count))
#define mem_map_dec_count(p) atomic_dec(&(p->count))

They were removed from wrapper.h in test10.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
