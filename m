Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTCFHrB>; Thu, 6 Mar 2003 02:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267886AbTCFHrB>; Thu, 6 Mar 2003 02:47:01 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:55201 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267881AbTCFHrA>;
	Thu, 6 Mar 2003 02:47:00 -0500
Message-ID: <3E66FF6B.2060301@wmich.edu>
Date: Thu, 06 Mar 2003 02:57:31 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
MIME-Version: 1.0
To: Corvus Corax <corvusvcorax@gemia.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux vs Windows temperature anomaly
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>	<p05210507ba8c20241329@[10.2.0.101]>	<3E66842F.9020000@WirelessNetworksInc.com>	<200303061038.44872.kernel@kolivas.org> <20030306081804.4717d1c4.corvusvcorax@gemia.de>
In-Reply-To: <20030306081804.4717d1c4.corvusvcorax@gemia.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is getting kicked like a deadhorse by now i think but.


Unlike your cpu which gets idle commands from the OS and thus has an 
idle loop where it turns off certain circuits and which can get acpi 
commands to turn completely off the other chips in the computer do not 
have such a luxury. they are always on like the cpus of yesteryear used 
to be.  It doesn't matter if they have data moving in them or not, no 
big difference.  The reason why it seems like this is the case is for 
you HSF cooled cpu guys, load on the system bus usually means high cpu 
load and that means more heat put into the surrounding air and the 
little usually passive cooled but regardless, less hot system bus gets 
hotter along with the cpu and cooler when the cpu is idle.   People 
cooled by other methods that do not dump heat into the surrounding air 
inside the case will notice that the system bus temp only varies with 
ambient air temp changes, not data transfer going on between ram and cpu.







Corvus Corax wrote:
> Am Thu, 6 Mar 2003 10:38:44 +1100
> schrieb Con Kolivas <kernel@kolivas.org>:
> 
> 
>>That doesn't make sense. His post said the temperature was 20 degrees lower 
>>when it failed.
>>
>>Con
> 
> 
> I think it does,
> 
> look at this:
> 
>                                                    RAM
>   ._____________________.
>  _|| | | | | | | | | | ||_.                     ._/| ._/|
> / ||___________________|| |~\                   ||/| ||/|
> | |O       _____       O| |~\\                 /||/| ||/|
> | |     .-°| | |°-.     | |\\\\               //|| | || |
> | |    / \ |~| | / \    | |\\\\\             //=|| |=|| |
> | |   /| |\| |~|/| |\   | |\\\\.________.   ///=||/|=||/|
> | |  * | | \_._/ |~| *  | |\===|        |==///==||/|=||/|
> | |  |~|~| /CPU\ ~ | |  | |====| north  |==///==|| |=|| |
> | |  | | |~\_ _/ | | |  | |====| bridge |=======|| |=|| |
> | |  * | | / ° \ | |~*  | |/===| (MEM ) |=======||/|=||/|
> | |   \| |/| |~|\|~|/   | |//==| (CTRL) |==\\\==||/|=||/|
> | |    \ / |~| | \ /    | |////°~~~~~~~~°==\\\==|| |=|| |
> | |     °-.|_|_|.-°     | |///// ||||||     \\\=|| |=|| |
> | |O                   O| |////  ||||||      \\=||/|=||/|
> | |~~~~~~~~~~~~~~~~~~~~~| |_//   ||||||       \\||/| ||/|
> °~|| | | | | | | | | | ||~°_/    ||||||        \|| | || |
>   °~~~~~~~~~~~~~~~~~~~~~°        ||||||         ||/  ||/
>          CPU TEMP |              ||||||         |_|  |_|
>                 | | voltage      ||||||
>                 | |||            ||||||
>                 | |||          .________.
>      Mainboard  | |||          |        |
>       TEMP      .,,,,,,. data  | south  |
>          O      |      |=======| bridge |
>          \\_____°''''''°       | (BUS ) |
>           °~~~~~~°             | (CTRL) |
>                 TEMP &         °~~~~~~~~°
>              VOLTAGE ctrl     ////|||\\\\\
>                chip            PCI & other BUS
> 
> 
> the sensor for the system temperature (somewhere on the board) is connected to a driver chip (usually on the i2c bus)
> like the w83781d (on my  board)
> 
> if something now causes the (often badly cooled) bridge to get hot (by more load between some periphery and the RAM for example)
> ,  the system temperature doesnt necessary have to increase.
> 
> if the bridge has only a heatsink, its temperature is somewhat like
> (system TEMP)+ ( produced heatper time /  heat given to the air by heatsink per time )
> where the heatsinks capacity is dependent on the delta temperature, too, gets complicated ;)
> 
> in short, the chips hotter than the rest of the system and if it has high load it gets even hotter,
> but its temp is still dependant on the main system TEMP. ;)
> 
> blahrgh forget what i talk, watch the ASCII art, and imagine the effect of much data running between
> BUS and RAM ;-) (or BUS and BUS if north and southbridge are on the same chip)
> 
> CvC
>


