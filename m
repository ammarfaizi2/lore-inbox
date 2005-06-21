Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVFUFPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVFUFPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVFUFOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:14:40 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:28195 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261904AbVFUFJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:09:21 -0400
Message-ID: <42B7A0FE.9060001@blueyonder.co.uk>
Date: Tue, 21 Jun 2005 06:09:18 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for yealink usb-p1k phone
References: <42B7990D.8000500@blueyonder.co.uk> <42B79BC6.3010201@blueyonder.co.uk> <42B79F92.9020306@blueyonder.co.uk>
In-Reply-To: <42B79F92.9020306@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2005 05:10:00.0178 (UTC) FILETIME=[7957AD20:01C5761F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> Sid Boyce wrote:
> 
>> Sid Boyce wrote:
>>
>>> I had to apply drivers/usb/Makefile and drivers/usb/input/Kconfig by 
>>> hand to 2.6.12, the rest applied ok.
>>> scripts/kconfig/conf -o arch/i386/Kconfig
>>> drivers/usb/input/Kconfig:213: syntax error, unexpected T_WORD
>>> drivers/usb/input/Kconfig:215: invalid menu option
>>> drivers/usb/input/Kconfig:216: syntax error, unexpected T_WORD
>>> drivers/usb/input/Kconfig:219: invalid menu option
>>> drivers/usb/input/Kconfig:219: syntax error, unexpected T_WORD
>>> drivers/usb/input/Kconfig:222: invalid menu option
>>> make[1]: *** [oldconfig] Error 1
>>> make: *** [oldconfig] Error 2
>>>
>>> My phone is the SkypePhone SK-04 (without the LCD) and this patch 
>>> seems to address the problems I'm having such keypad not working, no 
>>> ring or hands free/headset audio, the mic works in all 
>>> configurations. Currently it only works through the handset. 
>>> tech@phoneskype not responding to any of my emails.
>>> It could be finger trouble, I shall look again when I've had some sleep.
>>> Regards
>>> Sid.
>>
>>
>>
>> Oops, tabs were missing, it's building.
>> Regards
>> Sid.
> 
> 
>   CC      drivers/usb/input/yealink.o
> drivers/usb/input/yealink.c:928: error: redefinition of `struct yld_status'
> drivers/usb/input/yealink.c:934: error: redefinition of `struct 
> lcd_segment_map'
> drivers/usb/input/yealink.c:940: error: redefinition of `struct 
> pictogram_map'
> drivers/usb/input/yealink.c:944: error: redefinition of `struct 
> segment_map'
> In file included from drivers/usb/input/yealink.h:199,
>                  from drivers/usb/input/yealink.c:952:
> drivers/usb/input/yealink.h:34: error: redefinition of `cmd_INIT'
> drivers/usb/input/yealink.h:34: error: `cmd_INIT' previously defined here
> drivers/usb/input/yealink.h:39: error: redefinition of `cmd_KEYPRESS'
> drivers/usb/input/yealink.h:39: error: `cmd_KEYPRESS' previously defined 
> here
> drivers/usb/input/yealink.h:44: error: redefinition of `cmd_KEYCODE'
> drivers/usb/input/yealink.h:44: error: `cmd_KEYCODE' previously defined 
> here
> drivers/usb/input/yealink.h:50: error: redefinition of `cmd_LCD'
> drivers/usb/input/yealink.h:50: error: `cmd_LCD' previously defined here
> drivers/usb/input/yealink.h:55: error: redefinition of `cmd_TONE'
> drivers/usb/input/yealink.h:55: error: `cmd_TONE' previously defined here
> drivers/usb/input/yealink.h:60: error: redefinition of `cmd_LED_USB'
> drivers/usb/input/yealink.h:60: error: `cmd_LED_USB' previously defined 
> here
> In file included from drivers/usb/input/yealink.c:952:
> drivers/usb/input/yealink.h:204: error: redeclaration of `enum u16'
> In file included from drivers/usb/input/yealink.h:205,
>                  from drivers/usb/input/yealink.c:952:
> drivers/usb/input/yealink.h:34: error: conflicting types for `OP16_INIT'
> drivers/usb/input/yealink.h:34: error: previous declaration of `OP16_INIT'
> drivers/usb/input/yealink.h:39: error: conflicting types for 
> `OP16_KEYPRESS'
> drivers/usb/input/yealink.h:39: error: previous declaration of 
> `OP16_KEYPRESS'
> drivers/usb/input/yealink.h:44: error: conflicting types for `OP16_KEYCODE'
> drivers/usb/input/yealink.h:44: error: previous declaration of 
> `OP16_KEYCODE'
> drivers/usb/input/yealink.h:50: error: conflicting types for `OP16_LCD'
> drivers/usb/input/yealink.h:50: error: previous declaration of `OP16_LCD'
> drivers/usb/input/yealink.h:55: error: conflicting types for `OP16_TONE'
> drivers/usb/input/yealink.h:55: error: previous declaration of `OP16_TONE'
> drivers/usb/input/yealink.h:60: error: conflicting types for `OP16_LED_USB'
> drivers/usb/input/yealink.h:60: error: previous declaration of 
> `OP16_LED_USB'
> In file included from drivers/usb/input/yealink.c:952:
> drivers/usb/input/yealink.h:220: error: redefinition of `lcdMap'
> drivers/usb/input/yealink.h:220: error: `lcdMap' previously defined here
> drivers/usb/input/yealink.c:955: error: redefinition of `map_seg7'
> drivers/usb/input/yealink.c:94: error: `map_seg7' previously defined here
> drivers/usb/input/yealink.c:957: error: redefinition of `struct 
> yealink_dev'
> drivers/usb/input/yealink.c:997: error: redefinition of `setChar'
> drivers/usb/input/yealink.c:136: error: `setChar' previously defined here
> drivers/usb/input/yealink.c:1060: error: redefinition of `map_p1k_to_key'
> drivers/usb/input/yealink.c:199: error: `map_p1k_to_key' previously 
> defined here
> drivers/usb/input/yealink.c:1092: error: redefinition of `report_key'
> drivers/usb/input/yealink.c:231: error: `report_key' previously defined 
> here
> drivers/usb/input/yealink.c:1120: error: redefinition of 
> `yealink_do_idle_tasks'
> drivers/usb/input/yealink.c:259: error: `yealink_do_idle_tasks' 
> previously defined here
> drivers/usb/input/yealink.c:1178: error: redefinition of 
> `yealink_state_machine'
> drivers/usb/input/yealink.c:317: error: `yealink_state_machine' 
> previously defined here
> drivers/usb/input/yealink.c:1239: error: redefinition of `urb_irq_callback'
> drivers/usb/input/yealink.c:378: error: `urb_irq_callback' previously 
> defined here
> drivers/usb/input/yealink.c:1265: error: redefinition of `urb_ctl_callback'
> drivers/usb/input/yealink.c:404: error: `urb_ctl_callback' previously 
> defined here
> drivers/usb/input/yealink.c:1285: error: redefinition of `input_ev'
> drivers/usb/input/yealink.c:424: error: `input_ev' previously defined here
> drivers/usb/input/yealink.c:1303: error: redefinition of `input_open'
> drivers/usb/input/yealink.c:442: error: `input_open' previously defined 
> here
> drivers/usb/input/yealink.c:1332: error: redefinition of `input_close'
> drivers/usb/input/yealink.c:471: error: `input_close' previously defined 
> here
> drivers/usb/input/yealink.c:1347: error: redefinition of `show_map'
> drivers/usb/input/yealink.c:486: error: `show_map' previously defined here
> drivers/usb/input/yealink.c:1352: error: redefinition of `store_map'
> drivers/usb/input/yealink.c:491: error: `store_map' previously defined here
> drivers/usb/input/yealink.c:1368: error: redefinition of `show_line'
> drivers/usb/input/yealink.c:507: error: `show_line' previously defined here
> drivers/usb/input/yealink.c:1380: error: redefinition of `show_line1'
> drivers/usb/input/yealink.c:519: error: `show_line1' previously defined 
> here
> drivers/usb/input/yealink.c:1382: error: redefinition of `show_line2'
> drivers/usb/input/yealink.c:521: error: `show_line2' previously defined 
> here
> drivers/usb/input/yealink.c:1384: error: redefinition of `show_line3'
> drivers/usb/input/yealink.c:523: error: `show_line3' previously defined 
> here
> drivers/usb/input/yealink.c:1395: error: redefinition of `store_line'
> drivers/usb/input/yealink.c:534: error: `store_line' previously defined 
> here
> drivers/usb/input/yealink.c:1409: error: redefinition of `store_line1'
> drivers/usb/input/yealink.c:548: error: `store_line1' previously defined 
> here
> drivers/usb/input/yealink.c:1411: error: redefinition of `store_line2'
> drivers/usb/input/yealink.c:550: error: `store_line2' previously defined 
> here
> drivers/usb/input/yealink.c:1413: error: redefinition of `store_line3'
> drivers/usb/input/yealink.c:552: error: `store_line3' previously defined 
> here
> drivers/usb/input/yealink.c:1421: error: redefinition of `get_icons'
> drivers/usb/input/yealink.c:560: error: `get_icons' previously defined here
> drivers/usb/input/yealink.c:1436: error: redefinition of `set_icon'
> drivers/usb/input/yealink.c:575: error: `set_icon' previously defined here
> drivers/usb/input/yealink.c:1454: error: redefinition of `show_icon'
> drivers/usb/input/yealink.c:593: error: `show_icon' previously defined here
> drivers/usb/input/yealink.c:1456: error: redefinition of `hide_icon'
> drivers/usb/input/yealink.c:595: error: `hide_icon' previously defined here
> drivers/usb/input/yealink.c:1472: error: redefinition of 
> `dev_attr_map_seg7'
> drivers/usb/input/yealink.c:611: error: `dev_attr_map_seg7' previously 
> defined here
> drivers/usb/input/yealink.c:1473: error: redefinition of `dev_attr_line1'
> drivers/usb/input/yealink.c:612: error: `dev_attr_line1' previously 
> defined here
> drivers/usb/input/yealink.c:1474: error: redefinition of `dev_attr_line2'
> drivers/usb/input/yealink.c:613: error: `dev_attr_line2' previously 
> defined here
> drivers/usb/input/yealink.c:1475: error: redefinition of `dev_attr_line3'
> drivers/usb/input/yealink.c:614: error: `dev_attr_line3' previously 
> defined here
> drivers/usb/input/yealink.c:1476: error: redefinition of 
> `dev_attr_get_icons'
> drivers/usb/input/yealink.c:615: error: `dev_attr_get_icons' previously 
> defined here
> drivers/usb/input/yealink.c:1477: error: redefinition of 
> `dev_attr_show_icon'
> drivers/usb/input/yealink.c:616: error: `dev_attr_show_icon' previously 
> defined here
> drivers/usb/input/yealink.c:1478: error: redefinition of 
> `dev_attr_hide_icon'
> drivers/usb/input/yealink.c:617: error: `dev_attr_hide_icon' previously 
> defined here
> drivers/usb/input/yealink.c:1481: error: redefinition of 
> `remove_sysfs_files'
> drivers/usb/input/yealink.c:620: error: `remove_sysfs_files' previously 
> defined here
> drivers/usb/input/yealink.c:1492: error: redefinition of 
> `create_sysfs_files'
> drivers/usb/input/yealink.c:631: error: `create_sysfs_files' previously 
> defined here
> drivers/usb/input/yealink.c:1517: error: redefinition of `struct 
> yld_device'
> drivers/usb/input/yealink.c:1521: error: redefinition of `yld_device'
> drivers/usb/input/yealink.c:660: error: `yld_device' previously defined 
> here
> drivers/usb/input/yealink.c:1525: error: redefinition of `usb_table'
> drivers/usb/input/yealink.c:664: error: `usb_table' previously defined here
> drivers/usb/input/yealink.c:1531: error: redefinition of `usb_cleanup'
> drivers/usb/input/yealink.c:670: error: `usb_cleanup' previously defined 
> here
> drivers/usb/input/yealink.c:1556: error: redefinition of `usb_disconnect'
> drivers/usb/input/yealink.c:695: error: `usb_disconnect' previously 
> defined here
> drivers/usb/input/yealink.c:1565: error: redefinition of `usb_probe'
> drivers/usb/input/yealink.c:704: error: `usb_probe' previously defined here
> drivers/usb/input/yealink.c:1693: error: redefinition of `yealink_driver'
> drivers/usb/input/yealink.c:832: error: `yealink_driver' previously 
> defined here
> drivers/usb/input/yealink.c:1702: error: redefinition of `yealink_dev_init'
> drivers/usb/input/yealink.c:841: error: `yealink_dev_init' previously 
> defined here
> drivers/usb/input/yealink.c:1710: error: redefinition of `yealink_dev_exit'
> drivers/usb/input/yealink.c:849: error: `yealink_dev_exit' previously 
> defined here
> drivers/usb/input/yealink.c:1714: error: redefinition of 
> `__initcall_yealink_dev_init'
> drivers/usb/input/yealink.c:853: error: `__initcall_yealink_dev_init' 
> previously defined here
> drivers/usb/input/yealink.c:1715: error: redefinition of 
> `__exitcall_yealink_dev_exit'
> drivers/usb/input/yealink.c:854: error: `__exitcall_yealink_dev_exit' 
> previously defined here
> drivers/usb/input/yealink.c:1789: error: redefinition of `struct 
> yld_status'
> drivers/usb/input/yealink.c:1795: error: redefinition of `struct 
> lcd_segment_map'
> drivers/usb/input/yealink.c:1801: error: redefinition of `struct 
> pictogram_map'
> drivers/usb/input/yealink.c:1805: error: redefinition of `struct 
> segment_map'
> In file included from drivers/usb/input/yealink.h:199,
>                  from drivers/usb/input/yealink.c:1813:
> drivers/usb/input/yealink.h:34: error: redefinition of `cmd_INIT'
> drivers/usb/input/yealink.h:34: error: `cmd_INIT' previously defined here
> drivers/usb/input/yealink.h:39: error: redefinition of `cmd_KEYPRESS'
> drivers/usb/input/yealink.h:39: error: `cmd_KEYPRESS' previously defined 
> here
> drivers/usb/input/yealink.h:44: error: redefinition of `cmd_KEYCODE'
> drivers/usb/input/yealink.h:44: error: `cmd_KEYCODE' previously defined 
> here
> drivers/usb/input/yealink.h:50: error: redefinition of `cmd_LCD'
> drivers/usb/input/yealink.h:50: error: `cmd_LCD' previously defined here
> drivers/usb/input/yealink.h:55: error: redefinition of `cmd_TONE'
> drivers/usb/input/yealink.h:55: error: `cmd_TONE' previously defined here
> drivers/usb/input/yealink.h:60: error: redefinition of `cmd_LED_USB'
> drivers/usb/input/yealink.h:60: error: `cmd_LED_USB' previously defined 
> here
> In file included from drivers/usb/input/yealink.c:1813:
> drivers/usb/input/yealink.h:204: error: redeclaration of `enum u16'
> In file included from drivers/usb/input/yealink.h:205,
>                  from drivers/usb/input/yealink.c:1813:
> drivers/usb/input/yealink.h:34: error: redefinition of `OP16_INIT'
> drivers/usb/input/yealink.h:34: error: `OP16_INIT' previously defined here
> drivers/usb/input/yealink.h:39: error: redefinition of `OP16_KEYPRESS'
> drivers/usb/input/yealink.h:39: error: `OP16_KEYPRESS' previously 
> defined here
> drivers/usb/input/yealink.h:44: error: redefinition of `OP16_KEYCODE'
> drivers/usb/input/yealink.h:44: error: `OP16_KEYCODE' previously defined 
> here
> drivers/usb/input/yealink.h:50: error: redefinition of `OP16_LCD'
> drivers/usb/input/yealink.h:50: error: `OP16_LCD' previously defined here
> drivers/usb/input/yealink.h:55: error: redefinition of `OP16_TONE'
> drivers/usb/input/yealink.h:55: error: `OP16_TONE' previously defined here
> drivers/usb/input/yealink.h:60: error: redefinition of `OP16_LED_USB'
> drivers/usb/input/yealink.h:60: error: `OP16_LED_USB' previously defined 
> here
> In file included from drivers/usb/input/yealink.c:1813:
> drivers/usb/input/yealink.h:220: error: redefinition of `lcdMap'
> drivers/usb/input/yealink.h:220: error: `lcdMap' previously defined here
> drivers/usb/input/yealink.c:1816: error: redefinition of `map_seg7'
> drivers/usb/input/yealink.c:955: error: `map_seg7' previously defined here
> drivers/usb/input/yealink.c:1818: error: redefinition of `struct 
> yealink_dev'
> drivers/usb/input/yealink.c:1858: error: redefinition of `setChar'
> drivers/usb/input/yealink.c:997: error: `setChar' previously defined here
> drivers/usb/input/yealink.c:1921: error: redefinition of `map_p1k_to_key'
> drivers/usb/input/yealink.c:1060: error: `map_p1k_to_key' previously 
> defined here
> drivers/usb/input/yealink.c:1953: error: redefinition of `report_key'
> drivers/usb/input/yealink.c:1092: error: `report_key' previously defined 
> here
> drivers/usb/input/yealink.c:1981: error: redefinition of 
> `yealink_do_idle_tasks'
> drivers/usb/input/yealink.c:1120: error: `yealink_do_idle_tasks' 
> previously defined here
> drivers/usb/input/yealink.c:2039: error: redefinition of 
> `yealink_state_machine'
> drivers/usb/input/yealink.c:1178: error: `yealink_state_machine' 
> previously defined here
> drivers/usb/input/yealink.c:2100: error: redefinition of `urb_irq_callback'
> drivers/usb/input/yealink.c:1239: error: `urb_irq_callback' previously 
> defined here
> drivers/usb/input/yealink.c:2126: error: redefinition of `urb_ctl_callback'
> drivers/usb/input/yealink.c:1265: error: `urb_ctl_callback' previously 
> defined here
> drivers/usb/input/yealink.c:2146: error: redefinition of `input_ev'
> drivers/usb/input/yealink.c:1285: error: `input_ev' previously defined here
> drivers/usb/input/yealink.c:2164: error: redefinition of `input_open'
> drivers/usb/input/yealink.c:1303: error: `input_open' previously defined 
> here
> drivers/usb/input/yealink.c:2193: error: redefinition of `input_close'
> drivers/usb/input/yealink.c:1332: error: `input_close' previously 
> defined here
> drivers/usb/input/yealink.c:2208: error: redefinition of `show_map'
> drivers/usb/input/yealink.c:1347: error: `show_map' previously defined here
> drivers/usb/input/yealink.c:2213: error: redefinition of `store_map'
> drivers/usb/input/yealink.c:1352: error: `store_map' previously defined 
> here
> drivers/usb/input/yealink.c:2229: error: redefinition of `show_line'
> drivers/usb/input/yealink.c:1368: error: `show_line' previously defined 
> here
> drivers/usb/input/yealink.c:2241: error: redefinition of `show_line1'
> drivers/usb/input/yealink.c:1380: error: `show_line1' previously defined 
> here
> drivers/usb/input/yealink.c:2243: error: redefinition of `show_line2'
> drivers/usb/input/yealink.c:1382: error: `show_line2' previously defined 
> here
> drivers/usb/input/yealink.c:2245: error: redefinition of `show_line3'
> drivers/usb/input/yealink.c:1384: error: `show_line3' previously defined 
> here
> drivers/usb/input/yealink.c:2256: error: redefinition of `store_line'
> drivers/usb/input/yealink.c:1395: error: `store_line' previously defined 
> here
> drivers/usb/input/yealink.c:2270: error: redefinition of `store_line1'
> drivers/usb/input/yealink.c:1409: error: `store_line1' previously 
> defined here
> drivers/usb/input/yealink.c:2272: error: redefinition of `store_line2'
> drivers/usb/input/yealink.c:1411: error: `store_line2' previously 
> defined here
> drivers/usb/input/yealink.c:2274: error: redefinition of `store_line3'
> drivers/usb/input/yealink.c:1413: error: `store_line3' previously 
> defined here
> drivers/usb/input/yealink.c:2282: error: redefinition of `get_icons'
> drivers/usb/input/yealink.c:1421: error: `get_icons' previously defined 
> here
> drivers/usb/input/yealink.c:2297: error: redefinition of `set_icon'
> drivers/usb/input/yealink.c:1436: error: `set_icon' previously defined here
> drivers/usb/input/yealink.c:2315: error: redefinition of `show_icon'
> drivers/usb/input/yealink.c:1454: error: `show_icon' previously defined 
> here
> drivers/usb/input/yealink.c:2317: error: redefinition of `hide_icon'
> drivers/usb/input/yealink.c:1456: error: `hide_icon' previously defined 
> here
> drivers/usb/input/yealink.c:2333: error: redefinition of 
> `dev_attr_map_seg7'
> drivers/usb/input/yealink.c:1472: error: `dev_attr_map_seg7' previously 
> defined here
> drivers/usb/input/yealink.c:2334: error: redefinition of `dev_attr_line1'
> drivers/usb/input/yealink.c:1473: error: `dev_attr_line1' previously 
> defined here
> drivers/usb/input/yealink.c:2335: error: redefinition of `dev_attr_line2'
> drivers/usb/input/yealink.c:1474: error: `dev_attr_line2' previously 
> defined here
> drivers/usb/input/yealink.c:2336: error: redefinition of `dev_attr_line3'
> drivers/usb/input/yealink.c:1475: error: `dev_attr_line3' previously 
> defined here
> drivers/usb/input/yealink.c:2337: error: redefinition of 
> `dev_attr_get_icons'
> drivers/usb/input/yealink.c:1476: error: `dev_attr_get_icons' previously 
> defined here
> drivers/usb/input/yealink.c:2338: error: redefinition of 
> `dev_attr_show_icon'
> drivers/usb/input/yealink.c:1477: error: `dev_attr_show_icon' previously 
> defined here
> drivers/usb/input/yealink.c:2339: error: redefinition of 
> `dev_attr_hide_icon'
> drivers/usb/input/yealink.c:1478: error: `dev_attr_hide_icon' previously 
> defined here
> drivers/usb/input/yealink.c:2342: error: redefinition of 
> `remove_sysfs_files'
> drivers/usb/input/yealink.c:1481: error: `remove_sysfs_files' previously 
> defined here
> drivers/usb/input/yealink.c:2353: error: redefinition of 
> `create_sysfs_files'
> drivers/usb/input/yealink.c:1492: error: `create_sysfs_files' previously 
> defined here
> drivers/usb/input/yealink.c:2378: error: redefinition of `struct 
> yld_device'
> drivers/usb/input/yealink.c:2382: error: redefinition of `yld_device'
> drivers/usb/input/yealink.c:1521: error: `yld_device' previously defined 
> here
> drivers/usb/input/yealink.c:2386: error: redefinition of `usb_table'
> drivers/usb/input/yealink.c:1525: error: `usb_table' previously defined 
> here
> drivers/usb/input/yealink.c:2392: error: redefinition of `usb_cleanup'
> drivers/usb/input/yealink.c:1531: error: `usb_cleanup' previously 
> defined here
> drivers/usb/input/yealink.c:2417: error: redefinition of `usb_disconnect'
> drivers/usb/input/yealink.c:1556: error: `usb_disconnect' previously 
> defined here
> drivers/usb/input/yealink.c:2426: error: redefinition of `usb_probe'
> drivers/usb/input/yealink.c:1565: error: `usb_probe' previously defined 
> here
> drivers/usb/input/yealink.c:2554: error: redefinition of `yealink_driver'
> drivers/usb/input/yealink.c:1693: error: `yealink_driver' previously 
> defined here
> drivers/usb/input/yealink.c:2563: error: redefinition of `yealink_dev_init'
> drivers/usb/input/yealink.c:1702: error: `yealink_dev_init' previously 
> defined here
> drivers/usb/input/yealink.c:2571: error: redefinition of `yealink_dev_exit'
> drivers/usb/input/yealink.c:1710: error: `yealink_dev_exit' previously 
> defined here
> drivers/usb/input/yealink.c:2575: error: redefinition of 
> `__initcall_yealink_dev_init'
> drivers/usb/input/yealink.c:1714: error: `__initcall_yealink_dev_init' 
> previously defined here
> drivers/usb/input/yealink.c:2576: error: redefinition of 
> `__exitcall_yealink_dev_exit'
> drivers/usb/input/yealink.c:1715: error: `__exitcall_yealink_dev_exit' 
> previously defined here
> {standard input}: Assembler messages:
> {standard input}:2518: Error: symbol `cmd_INIT' is already defined
> {standard input}:2537: Error: symbol `cmd_KEYPRESS' is already defined
> {standard input}:2556: Error: symbol `cmd_KEYCODE' is already defined
> {standard input}:2575: Error: symbol `cmd_LCD' is already defined
> {standard input}:2594: Error: symbol `cmd_TONE' is already defined
> {standard input}:2613: Error: symbol `cmd_LED_USB' is already defined
> {standard input}:2634: Error: symbol `lcdMap' is already defined
> {standard input}:3125: Error: symbol `map_seg7' is already defined
> {standard input}:3267: Error: symbol `dev_attr_map_seg7' is already defined
> {standard input}:3277: Error: symbol `dev_attr_line1' is already defined
> {standard input}:3287: Error: symbol `dev_attr_line2' is already defined
> {standard input}:3297: Error: symbol `dev_attr_line3' is already defined
> {standard input}:3307: Error: symbol `dev_attr_get_icons' is already 
> defined
> {standard input}:3317: Error: symbol `dev_attr_show_icon' is already 
> defined
> {standard input}:3327: Error: symbol `dev_attr_hide_icon' is already 
> defined
> {standard input}:3338: Error: symbol `yld_device' is already defined
> {standard input}:3346: Error: symbol `usb_table' is already defined
> {standard input}:3357: Error: symbol `yealink_driver' is already defined
> {standard input}:3369: Error: symbol `__initcall_yealink_dev_init' is 
> already defined
> {standard input}:3375: Error: symbol `__exitcall_yealink_dev_exit' is 
> already defined
> {standard input}:3380: Error: symbol `cmd_INIT' is already defined
> {standard input}:3399: Error: symbol `cmd_KEYPRESS' is already defined
> {standard input}:3418: Error: symbol `cmd_KEYCODE' is already defined
> {standard input}:3437: Error: symbol `cmd_LCD' is already defined
> {standard input}:3456: Error: symbol `cmd_TONE' is already defined
> {standard input}:3475: Error: symbol `cmd_LED_USB' is already defined
> {standard input}:3496: Error: symbol `lcdMap' is already defined
> {standard input}:3987: Error: symbol `map_seg7' is already defined
> {standard input}:4129: Error: symbol `dev_attr_map_seg7' is already defined
> {standard input}:4139: Error: symbol `dev_attr_line1' is already defined
> {standard input}:4149: Error: symbol `dev_attr_line2' is already defined
> {standard input}:4159: Error: symbol `dev_attr_line3' is already defined
> {standard input}:4169: Error: symbol `dev_attr_get_icons' is already 
> defined
> {standard input}:4179: Error: symbol `dev_attr_show_icon' is already 
> defined
> {standard input}:4189: Error: symbol `dev_attr_hide_icon' is already 
> defined
> {standard input}:4200: Error: symbol `yld_device' is already defined
> {standard input}:4208: Error: symbol `usb_table' is already defined
> {standard input}:4219: Error: symbol `yealink_driver' is already defined
> {standard input}:4231: Error: symbol `__initcall_yealink_dev_init' is 
> already defined
> {standard input}:4237: Error: symbol `__exitcall_yealink_dev_exit' is 
> already defined
> make[3]: *** [drivers/usb/input/yealink.o] Error 1
> make[2]: *** [drivers/usb/input] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> Regards
> Sid.

Apologies yet again, duplication in file caused by repatching.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
