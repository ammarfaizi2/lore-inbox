Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278298AbRJWVG4>; Tue, 23 Oct 2001 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278297AbRJWVGr>; Tue, 23 Oct 2001 17:06:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30731 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278289AbRJWVGe>; Tue, 23 Oct 2001 17:06:34 -0400
Message-ID: <3BD5DBEE.7020105@zytor.com>
Date: Tue, 23 Oct 2001 14:06:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <Pine.LNX.3.95.1011023170019.21142A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> 
> Presently, when /initrd/{ash.static} runs off the end of the
>  /initrd/linuxrc script, the kernel tries to mount the root
> defined for LILO. So I add some program that executes 'pivot-root'
> instead of just letting the script run off the end?
> 


You do something like:

cd /newroot
pivot_root /newroot /newroot/oldroot
exec /sbin/init < /dev/console > /dev/console 2>&1

