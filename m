Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRA0Nll>; Sat, 27 Jan 2001 08:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbRA0Nlc>; Sat, 27 Jan 2001 08:41:32 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:40924 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S131224AbRA0NlW>; Sat, 27 Jan 2001 08:41:22 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Wed, 24 Jan 2001 23:14:25
Subject: Re: display problem with matroxfb
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010127134127Z131224-460+582@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 21:57:56, "Petr Vandrovec" <VANDROVE@vc.cvut.cz> 
wrote:

> you do not have to specify vesa,pixclock,hslen and vslen, as you leave
> them on defaults. 

Talking of defaults for matroxfb, would you consider limiting the fv: 
value default to something reasonable that'll work on all monitors? It
took me several recompiles/reboots to get a setting that would not put
my monitor into auto-powerdown. If you defaulted to fv:60 then it 
would work on 99.9% of monitors and then people could override that 
upwards. I have a Philips 201B 21" monitor and was using 

append="video=matrox:vesa:400"

and this was setting too high a vertical refresh rate for the monitors
capabilities. Adding fv:85 lets it work. The card is a Matrox 
Millennium G200 8MB SDRAM.

trevor@trevor4:/usr/src/linux > grep ^C .config|grep FB
CONFIG_FB=y            
CONFIG_FB_MATROX=y     
CONFIG_FB_MATROX_G100=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y    
CONFIG_FBCON_CFB16=y   
CONFIG_FBCON_CFB24=y   
CONFIG_FBCON_CFB32=y   
CONFIG_FBCON_FONTS=y   

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
