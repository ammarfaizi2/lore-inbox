Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRKPWMW>; Fri, 16 Nov 2001 17:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281572AbRKPWMM>; Fri, 16 Nov 2001 17:12:12 -0500
Received: from mail.spylog.com ([194.67.35.220]:9125 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S281489AbRKPWLs>;
	Fri, 16 Nov 2001 17:11:48 -0500
Date: Sat, 17 Nov 2001 01:11:40 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Fwd:
Message-ID: <20011117011140.A24519@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

 Hardware: Intel L440GX+ (with onboard aic)

Adaptec AIC7xxx driver version: 6.2.4
aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

kernel 2.4.12-15pre5

@ruby:/proc/scsi$ cat scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
@ruby:/proc/scsi$


Whis is hardware or kernel (aic78xx scsi driver) ?


after 1-2 hours uptime:


...
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 69
Card NEXTQSCB = 86
QINFIFO entries: 86 49 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 49, 86
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 49
Card NEXTQSCB = 69
QINFIFO entries: 69 86 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 86, 69
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 86
Card NEXTQSCB = 49
QINFIFO entries: 49 69 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 69, 49
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 69
Card NEXTQSCB = 86
QINFIFO entries: 86 49 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 49, 86
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 49
Card NEXTQSCB = 69
QINFIFO entries: 69 86 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 86, 69
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 86
Card NEXTQSCB = 49
QINFIFO entries: 49 69 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 69, 49
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 69
Card NEXTQSCB = 86
QINFIFO entries: 86 49 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 49, 86
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 49
Card NEXTQSCB = 69
QINFIFO entries: 69 86 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 86, 69
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 86
Card NEXTQSCB = 49
QINFIFO entries: 49 69 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 69, 49
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x167
ACCUM = 0x56, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x15
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x14, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x2
STACK == 0x175, 0x15f, 0x0, 0x35
SCB count = 184
Kernel NEXTQSCB = 69
Card NEXTQSCB = 86
QINFIFO entries: 86 49 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 11 8 29 30 3 14 21 5 27 16 25 13 26 22 19 17 28 24 1 18 20 9 6 7 15 31 10 2 4 12 0 
Pending list: 49, 86
Kernel Free SCB list: 120 41 47 126 89 175 154 94 178 102 22 58 72 67 155 129 30 62 96 74 44 5 79 131 132 23 60 159 144 56 73 54 45 42 118 6 93 157 15 53 182 59 25 57 32 1 113 84 138 90 20 38 123 170 81 61 78 34 99 114 55 75 19 111 109 158 136 128 26 82 8 50 172 143 163 83 100 2 161 149 18 152 68 156 169 135 28 17 160 4 9 150 91 173 27 139 124 115 10 174 66 31 37 105 127 98 92 145 35 168 116 137 64 130 165 110 183 164 24 48 39 14 181 119 52 134 65 0 85 167 141 40 7 162 3 46 133 95 33 80 166 151 21 77 177 29 63 122 176 142 153 179 121 146 76 97 104 107 88 11 13 16 12 171 106 125 87 112 101 117 51 43 70 36 71 108 147 103 140 148 180 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
Recovery SCB completes
(scsi0:A:0:0): Unexpected busfree in Command phase
SEQADDR == 0x167

----- End forwarded message -----

-- 
bye.
Andrey Nekrasov, SpyLOG.
